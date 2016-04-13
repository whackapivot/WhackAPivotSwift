import Quick
import Nimble
import CBGPromise

@testable import WhackAPivotSwift

class FakeDataSession: NSURLSessionDataTask {
    override func resume() {}
}

class FakeNSURLSession: NSURLSession {
    var peopleInput: NSArray?
    var urlToExpect: NSURL?
    
    override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        var data: NSData = NSData()
        guard request.URL == urlToExpect else { return FakeDataSession() }
        do {
            data = try NSJSONSerialization.dataWithJSONObject(peopleInput!, options: .PrettyPrinted)
            completionHandler(data, nil, nil)
        } catch {
        }
        return FakeDataSession()
    }
}

class FakeURLProvider: URLProvider {
    var urlToReturn: NSURL?
    
    func urlForPath(path: String) -> NSURL {
        return NSURL()
    }
    
    func getPeopleURL() -> NSURL {
        return urlToReturn!
    }
}

class PeopleServiceSpec: QuickSpec {
    override func spec() {
        describe("PeopleService") {
            let fakeTokenStore = FakeTokenStore()
            let fakeURL = NSURL(string: "http://example.com")
            let fakeNSURLSession = FakeNSURLSession()
            let fakeURLProvider = FakeURLProvider()
            
            let subject = PeopleServiceImpl(tokenStore: fakeTokenStore,
                                            session: fakeNSURLSession,
                                            urlProvider: fakeURLProvider)
            
            let fakeToken = "FakeTokenString123"
            fakeTokenStore.token = fakeToken
            
            describe("#getPeople") {
                let peopleInput = [
                    ["id":1121, "first_name":"First","last_name":"Person","location_name":"Los Angeles","photo_url":"First Image"],
                    ["id":1379,"first_name":"Aaron","last_name":"Hurley","location_name":"San Francisco","photo_url":"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1379/IMG_2138.JPG",],
                    ["id":839,"first_name":"Second","last_name":"Person","location_name":"Los Angeles","photo_url":"Second Image"]
                ]
                
                let expectedPeople = [
                    Person(name: "First Person", image: subject.dummyImage!, id: 1121),
                    Person(name: "Second Person", image: subject.dummyImage!, id: 839),
                    ]
                var promise: Promise<[Person]?, NSError> = Promise()
                
                beforeEach {
                    promise = Promise<[Person]?, NSError>()
                    fakeURLProvider.urlToReturn = fakeURL
                    fakeNSURLSession.peopleInput = peopleInput
                    fakeNSURLSession.urlToExpect = fakeURL
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