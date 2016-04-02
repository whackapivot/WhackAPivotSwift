//
//  PeopleChoicesAndTargetServiceSpec.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/1/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import WhackAPivotSwift

class PeopleChoicesAndTargetServiceSpec: SwinjectSpec {
    override func spec() {
        describe("PeopleChoicesAndTargetService") {
            var peopleChoicesAndTargetService: PeopleChoicesAndTargetService!
            var fakePeopleService: FakePeopleService!
            var fakePeopleRandomizer: FakePeopleRandomizer!
            
            let fakePeople = [
                Person(name: "Joe", image: "Joe Image"),
                Person(name: "Steve", image: "Steve Image"),
                Person(name: "Steve2", image: "Steve2 Image"),
                Person(name: "Steve3", image: "Steve3 Image"),
                Person(name: "Steve4", image: "Steve4 Image"),
                Person(name: "Steve5", image: "Steve5 Image"),
                Person(name: "Steve6", image: "Steve5 Image"),
                Person(name: "Steve7", image: "Steve5 Image"),
                Person(name: "Steve8", image: "Steve5 Image"),
            ]
            
            beforeEach {
                fakePeopleService = FakePeopleService()
                fakePeopleRandomizer = FakePeopleRandomizer()
                
                self.testContainer.register(PeopleChoicesAndTargetService.self) { _ in
                    PeopleChoicesAndTargetServiceImpl(peopleService: fakePeopleService, peopleRandomizer: fakePeopleRandomizer)
                }
                
                fakePeopleService.getPeopleReturns(fakePeople)
                
                peopleChoicesAndTargetService = self.testContainer.resolve(PeopleChoicesAndTargetService.self)!
            }
            
            it("Should obtain people from the PeopleService") {
                expect(fakePeopleService.getPeopleCallCount).to(equal(1))
            }
            
            describe("#provide") {
                var result: PeopleChoicesAndTarget!
                let stubbedResult = PeopleChoicesAndTarget(peopleChoices: [fakePeople[0]], target: 0)
                
                beforeEach {
                    fakePeopleRandomizer.getRandomSubsetReturns(stubbedResult)
                    
                    result = peopleChoicesAndTargetService.provide()
                }
                
                it("should obtain a PeopleChoicesAndTarget from the randomizer") {
                    expect(fakePeopleRandomizer.getRandomSubsetCallCount).to(equal(1));
                    
                    let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(0)
                    expect(args.0).to(equal(fakePeople))
                    expect(args.1).to(equal([]))
                    
                    expect(result).to(equal(stubbedResult))
                }
                
                describe("When calling a second time") {
                    var personToAvoid: Person!
                    let secondStubbedResult = PeopleChoicesAndTarget(peopleChoices: [fakePeople[0]], target: 3)
                    
                    beforeEach {
                        personToAvoid = fakePeople[result.target];
                        fakePeopleRandomizer.getRandomSubsetReturns(secondStubbedResult)
                        result = peopleChoicesAndTargetService.provide()
                    }
                    
                    it("should call the randomizer with the previous target in people to avoid") {
                        expect(fakePeopleRandomizer.getRandomSubsetCallCount).to(equal(2));
                        
                        let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(1)
                        expect(args.0).to(equal(fakePeople))
                        expect(args.1).to(equal([personToAvoid]))
                    }
                }
            }
        }
    }
}
