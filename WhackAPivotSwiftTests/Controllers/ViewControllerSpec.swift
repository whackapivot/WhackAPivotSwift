//
//  WhackAPivotSwiftTests.swift
//  WhackAPivotSwiftTests
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import WhackAPivotSwift

class ViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("ViewController") {
            var viewController: ViewController!
            var fakePeopleChoicesAndTargetService: FakePeopleChoicesAndTargetService!
            
            let fakePeople = [
                Person(name: "Joe", image: "Joe Image"),
                Person(name: "Steve", image: "Steve Image"),
                Person(name: "Steve2", image: "Steve2 Image"),
                Person(name: "Steve3", image: "Steve3 Image"),
                Person(name: "Steve4", image: "Steve4 Image"),
                Person(name: "Steve5", image: "Steve5 Image"),
            ]

            beforeEach {
                fakePeopleChoicesAndTargetService = FakePeopleChoicesAndTargetService()
                
                fakePeopleChoicesAndTargetService.provideReturns(
                    PeopleChoicesAndTarget(peopleChoices: fakePeople, target: 1)
                )
                
                self.testContainer.registerForStoryboard(ViewController.self) { _, controller in
                    controller.peopleChoicesAndTargetService = fakePeopleChoicesAndTargetService
                    controller.personDisplayer = PersonDisplayerImpl()
                }
                
                
                viewController = self.startController("ViewController", storyboardName: "Main") as! ViewController
            }
        
            
            it("has a hidden result label") {
                expect(viewController.resultLabel.hidden).to(beTruthy())
            }
            
            it("it obtains a PeopleChoicesAndTarget") {
                expect(fakePeopleChoicesAndTargetService.provideCallCount).to(equal(1))
            }
            
            it("sets the nameLabel to the name of the target person") {
                expect(viewController.nameLabel.text).to(equal("Steve"))
            }
            
            describe("clicking the correct image after an incorrect one") {
                beforeEach {
                    viewController.clickedOnButton(viewController.personButtons[1])
                }
                
                it("it obatins a new PeopleChoicesAndTarget") {
                    expect(fakePeopleChoicesAndTargetService.provideCallCount).to(equal(2))
                }
            }
            
            describe("clicking an incorrect image") {
                beforeEach {
                    viewController.clickedOnButton(viewController.personButtons[0])
                }
                
                it("unhides the result message and displays Incorrect") {
                    expect(viewController.resultLabel.text).to(equal("Incorrect!"))
                    expect(viewController.resultLabel.hidden).to(beFalsy())
                }
                
                describe("And then a correct one") {
                    beforeEach {
                        viewController.clickedOnButton(viewController.personButtons[1])
                    }

                    it("shows a blank result message") {
                        expect(viewController.resultLabel.hidden).to(beTruthy())
                    }
                }
            }
            
            describe("correctly clicking the last image of the set") {
                
            }
        }
    }
}

