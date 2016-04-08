import Quick
import Nimble
import CBGPromise

@testable import WhackAPivotSwift

class FakeDataSession: NSURLSessionDataTask {
    override func resume() {}
}

class FakeNSURLSession: NSURLSession {
    var peopleInput: NSArray?
    var request: NSURLRequest!
    
    override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        self.request = request
        var data: NSData = NSData()
        do {
            data = try NSJSONSerialization.dataWithJSONObject(peopleInput!, options: .PrettyPrinted)
            completionHandler(data, nil, nil)
        } catch {
        }
        return FakeDataSession()
    }
}

class PeopleServiceSpec: QuickSpec {
    override func spec() {
        describe("PeopleService") {
            let fakeTokenStore = FakeTokenStore()
            let fakeNSURLSession = FakeNSURLSession()
            
            let subject = PeopleServiceImpl(tokenStore: fakeTokenStore,
                                            session: fakeNSURLSession)
            
            let fakeToken = "FakeTokenString123"
            fakeTokenStore.token = fakeToken
            
            describe("#getPeople") {
                let peopleInput = [
                    ["id":1121,"email":"ashah@pivotal.io","first_name":"First","last_name":"Person","title":"Engineer","phone":"","twitter":"","github":"aashah","location_name":"Los Angeles","photo_url":"First Image","started_on":1403481600,"manager":false,"pivot_role":"Pivot","billable":true,"normalized_first_name":"Aakash","normalized_last_name":"Shah","current_project":"null","ein":"null","blurb":"","supervisor_name":"Matt Royal","supervisor_id":299],
                    ["id":1379,"email":"ahurley@pivotal.io","first_name":"Aaron","last_name":"Hurley","title":"Engineer","phone":"","twitter":"","github":"","location_name":"San Francisco","photo_url":"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1379/IMG_2138.JPG","started_on":1427068800,"manager":false,"pivot_role":"Pivot","billable":true,"normalized_first_name":"Aaron","normalized_last_name":"Hurley","current_project":"null","ein":"null","blurb":"","supervisor_name":"Aram Price","supervisor_id":588],
                    ["id":839,"email":"ajarecki@pivotal.io","first_name":"Second","last_name":"Person","title":"Engineer","phone":"null","twitter":"null","github":"null","location_name":"Los Angeles","photo_url":"Second Image","started_on":1350259200,"manager":false,"pivot_role":"Pivot","billable":true,"normalized_first_name":"Aaron","normalized_last_name":"Jarecki","current_project":"null","ein":"null","blurb":"null","supervisor_name":"Joshua Winters","supervisor_id":770]
                ]
                
                let expectedPeople = [
                    Person(name: "First Person", image: "First Image"),
                    Person(name: "Second Person", image: "Second Image"),
                    ]
                
                var promise: Promise<[Person]?, NSError> = Promise()
                
                beforeEach {
                    promise = Promise<[Person]?, NSError>()
                    fakeNSURLSession.peopleInput = peopleInput
                    promise = subject.getPeople()
                }
                
                describe("When people are not already stored") {
                    describe("when the network call succeeds") {
                        it("will resolve the promise with the people") {
                            expect(promise.future.value).toNot(beNil())
                            expect(promise.future.value!).to(equal(expectedPeople))
                        }
                    }
                    describe("when the network call fails") {
                    }
                }
            }
        }
    }
}