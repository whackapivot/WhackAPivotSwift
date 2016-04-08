import Quick
import Nimble
import Swinject
import CBGPromise

@testable import WhackAPivotSwift

class GameViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("GameViewController") {
            var gameViewController: GameViewController!
            var fakePersonChallengeService: FakePersonChallengeService!
            var fakePersonDisplayer: FakePersonDisplayer!
            let fakePeopleStore = PeopleStoreImpl()
            
            let fakePeople = [
                Person(name: "Joe", image: UIImage()),
                Person(name: "Steve", image: UIImage()),
                Person(name: "Steve2", image: UIImage()),
                Person(name: "Steve3", image: UIImage()),
                Person(name: "Steve4", image: UIImage()),
                Person(name: "Steve5", image: UIImage()),
            ]
            
            let fakePeople2 = [
                Person(name: "Joe7", image: UIImage()),
                Person(name: "Steve7", image: UIImage()),
                Person(name: "Steve27", image: UIImage()),
                Person(name: "Steve37", image: UIImage()),
                Person(name: "Steve47", image: UIImage()),
                Person(name: "Steve57", image: UIImage()),
            ]
            
            beforeEach {
                fakePersonChallengeService = FakePersonChallengeService()
                fakePersonDisplayer = FakePersonDisplayer()
                
                self.testContainer.registerForStoryboard(GameViewController.self) { _, controller in
                    controller.personChallengeService = fakePersonChallengeService
                    controller.personDisplayer = fakePersonDisplayer
                    controller.peopleStore = fakePeopleStore
                }
                fakePeopleStore.people = fakePeople
                fakePersonChallengeService.getChallengeReturns(PersonChallenge(peopleChoices: fakePeople, target: 1))

                gameViewController = self.startController("GameViewController", storyboardName: "Main") as! GameViewController
            }
        
            it("displays the correct set of people") {
                expect(fakePersonDisplayer.displayCallCount).to(equal(6))
                expect(fakePersonDisplayer.displayArgsForCall(0).0).to(equal(fakePeople[0]))
                expect(fakePersonDisplayer.displayArgsForCall(1).0).to(equal(fakePeople[1]))
                expect(fakePersonDisplayer.displayArgsForCall(2).0).to(equal(fakePeople[2]))
                expect(fakePersonDisplayer.displayArgsForCall(3).0).to(equal(fakePeople[3]))
                expect(fakePersonDisplayer.displayArgsForCall(4).0).to(equal(fakePeople[4]))
                expect(fakePersonDisplayer.displayArgsForCall(5).0).to(equal(fakePeople[5]))
            }
            
            it("sets the nameLabel to the name of the target person") {
                expect(gameViewController.nameLabel.text).to(equal("Steve"))
            }
            
            it("has a hidden result label") {
                expect(gameViewController.resultLabel.hidden).to(beTruthy())
            }
            
            describe("clicking the correct image after an incorrect one") {
                beforeEach {
                    fakePersonChallengeService.getChallengeReturns(PersonChallenge(peopleChoices: fakePeople2, target: 1))
                    gameViewController.clickedOnButton(gameViewController.personButtons[1])
                }
                
                it("displays the new set of people") {
                    expect(fakePersonDisplayer.displayCallCount).to(equal(12))
                    expect(fakePersonDisplayer.displayArgsForCall(6).0).to(equal(fakePeople2[0]))
                    expect(fakePersonDisplayer.displayArgsForCall(7).0).to(equal(fakePeople2[1]))
                    expect(fakePersonDisplayer.displayArgsForCall(8).0).to(equal(fakePeople2[2]))
                    expect(fakePersonDisplayer.displayArgsForCall(9).0).to(equal(fakePeople2[3]))
                    expect(fakePersonDisplayer.displayArgsForCall(10).0).to(equal(fakePeople2[4]))
                    expect(fakePersonDisplayer.displayArgsForCall(11).0).to(equal(fakePeople2[5]))
                }
                
                it("updates the target person name label") {
                    expect(gameViewController.nameLabel.text).to(equal("Steve7"))
                }
            }
            
            describe("clicking an incorrect image") {
                beforeEach {
                    gameViewController.clickedOnButton(gameViewController.personButtons[0])
                }
                
                it("unhides the result message and displays Incorrect") {
                    expect(gameViewController.resultLabel.text).to(equal("Incorrect!"))
                    expect(gameViewController.resultLabel.hidden).to(beFalsy())
                }
                
                describe("And then a correct one") {
                    beforeEach {
                        gameViewController.clickedOnButton(gameViewController.personButtons[1])
                    }

                    it("shows a blank result message") {
                        expect(gameViewController.resultLabel.hidden).to(beTruthy())
                    }
                }
            }
            
            describe("Correctly clicking the last image of the set") {
                beforeEach {
                    fakePersonChallengeService.getChallengeReturns(nil)
                    gameViewController.clickedOnButton(gameViewController.personButtons[1])
                }
                
                   it("should not crash") {
                    expect(true).to(beTruthy())
                }
                
                describe("And then clicking again") {
                    beforeEach {
                        gameViewController.clickedOnButton(gameViewController.personButtons[1])
                    }

                    it("should not crash") {
                        expect(true).to(beTruthy())
                    }

                }
            }
        }
    }
}

