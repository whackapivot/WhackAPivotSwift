import Quick
import Nimble
import Swinject
import WebKit
import CBGPromise

@testable import WhackAPivotSwift

class PeopleViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("PeopleViewController") {
            var controller: PeopleViewController!
            var fakePeopleService: FakePeopleService!
            var fakePeopleStore: FakePeopleStore!
            
            beforeEach {
                fakePeopleService = FakePeopleService()
                fakePeopleStore = FakePeopleStore()
                
                self.testContainer.registerForStoryboard(PeopleViewController.self) { _, controller in
                    controller.peopleService = fakePeopleService
                    controller.peopleStore = fakePeopleStore
                }
                
                controller = self.instantiateController("PeopleViewController", storyboardName: "Main") as! PeopleViewController
                _ = controller.view
            }
            
            describe("#viewDidAppear") {
                let fakePromise = Promise<[Person]?, NSError>()
                let people = [Person(name: "some name"), Person(name: "another")]

                beforeEach {
                    fakePeopleService.getPeopleReturns(fakePromise)
                    controller.viewDidAppear(false)
                }
                
                describe("When people service resolves") {
                    beforeEach {
                        fakePromise.resolve(people)
                    }
                    it("should save the people to the PeopleStore") {
                        expect(fakePeopleStore.people).toEventually(equal(people))
                        
                    }
                    it("should segue to the PeopleController") {
                        expect(controller.segueToPeoplePerformed).toEventually(beTruthy())
                    }
                }
                describe("When people service fails") {
                    beforeEach {
                        fakePromise.reject(NSError(domain: "", code: 0, userInfo: nil))
                    }

                    it("should segue to the LoginController") {
                        expect(controller.segueToLoginPerformed).toEventually(beTruthy())
                    }
                    
                }
            }
        }
    }
}


