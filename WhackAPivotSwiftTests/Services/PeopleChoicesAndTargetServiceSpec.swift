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
                Person(name: "Steve6", image: "Steve6 Image"),
                Person(name: "Steve7", image: "Steve7 Image"),
                Person(name: "Steve8", image: "Steve8 Image"),
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
                let stubbedResult = PeopleChoicesAndTarget(peopleChoices: [fakePeople[1]], target: 0)
                
                beforeEach {
                    fakePeopleRandomizer.getRandomSubsetReturns(stubbedResult)
                    
                    result = peopleChoicesAndTargetService.provide()
                }
                
                it("should obtain a PeopleChoicesAndTarget from the randomizer") {
                    expect(fakePeopleRandomizer.getRandomSubsetCallCount).to(equal(1));
                    
                    let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(0)
                    expect(args.0).to(equal(6))
                    expect(args.1).to(equal(fakePeople))
                    expect(args.2).to(equal([]))
                    
                    expect(result).to(equal(stubbedResult))
                }
                
                describe("When calling a second time") {
                    var personToAvoid: Person!
                    let secondStubbedResult = PeopleChoicesAndTarget(peopleChoices: [fakePeople[0]], target: 0)
                    
                    beforeEach {
                        personToAvoid = stubbedResult.peopleChoices[result.target];
                        fakePeopleRandomizer.getRandomSubsetReturns(secondStubbedResult)
                        result = peopleChoicesAndTargetService.provide()
                    }
                    
                    it("should call the randomizer with the previous target in people to avoid") {
                        expect(fakePeopleRandomizer.getRandomSubsetCallCount).to(equal(2));
                        
                        let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(1)
                        expect(args.0).to(equal(6))
                        expect(args.1).to(equal(fakePeople))
                        expect(args.2).to(equal([personToAvoid]))
                    }
                }
                
                describe("When all people have been exhausted") {
                    beforeEach {
                        let peopleIndices = Array([0] + Array(2...8))
                        for i: Int in peopleIndices {
                            fakePeopleRandomizer.getRandomSubsetReturns(PeopleChoicesAndTarget(peopleChoices: [fakePeople[i]], target: 0))
                            peopleChoicesAndTargetService.provide()
                            }
                    }
                    
                    it("starts over again with no one to avoid") {
                        peopleChoicesAndTargetService.provide()
                        NSLog("Call count is \(fakePeopleRandomizer.getRandomSubsetCallCount)")
                        let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(9)
                        expect(args.2).to(equal([]))
                    }
                }
            }
        }
    }
}
