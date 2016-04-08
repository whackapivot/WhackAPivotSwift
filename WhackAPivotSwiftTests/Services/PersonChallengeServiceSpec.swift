import Quick
import Nimble
import Swinject

@testable import WhackAPivotSwift

class PersonChallengeServiceSpec: SwinjectSpec {
    override func spec() {
        fdescribe("PersonChallengeService") {
            var personChallengeService: PersonChallengeService!
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
                fakePeopleRandomizer = FakePeopleRandomizer()
                
                self.testContainer.register(PersonChallengeService.self) { _ in
                    PersonChallengeServiceImpl(peopleRandomizer: fakePeopleRandomizer)
                }
                
                personChallengeService = self.testContainer.resolve(PersonChallengeService.self)!
                personChallengeService.startNewGame(fakePeople, peoplePerChallenge: 6)
            }
            
            describe("#getChallenge") {
                let stubbedResult = PersonChallenge(peopleChoices: [fakePeople[1]], target: 0)
                var result: PersonChallenge?
                
                beforeEach {
                    fakePeopleRandomizer.getRandomSubsetReturns(stubbedResult)
                    
                    result = personChallengeService.getChallenge()
                }
                
                it("should obtain a PersonChallenge from the randomizer") {
                    expect(fakePeopleRandomizer.getRandomSubsetCallCount).to(equal(1));
                    
                    let args = fakePeopleRandomizer.getRandomSubsetArgsForCall(0)
                    expect(args.0).to(equal(6))
                    expect(args.1).to(equal(fakePeople))
                    expect(args.2).to(equal([]))
                    
                    expect(result).to(equal(stubbedResult))
                }
                
                describe("When calling a second time") {
                    var personToAvoid: Person!
                    let secondStubbedResult = PersonChallenge(peopleChoices: [fakePeople[0]], target: 0)
                    
                    beforeEach {
                        personToAvoid = stubbedResult.peopleChoices[result!.target];
                        fakePeopleRandomizer.getRandomSubsetReturns(secondStubbedResult)
                        result = personChallengeService.getChallenge()
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
                            fakePeopleRandomizer.getRandomSubsetReturns(PersonChallenge(peopleChoices: [fakePeople[i]], target: 0))
                            personChallengeService.getChallenge()
                            }
                    }
                    
                    it("returns nil") {
                        expect(personChallengeService.getChallenge()).to(beNil())
                    }
                }
            }
        }
    }
}
