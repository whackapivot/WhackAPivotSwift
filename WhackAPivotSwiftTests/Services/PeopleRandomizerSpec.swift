import Quick
import Nimble

@testable import WhackAPivotSwift

class PeopleRandomizerSpec: QuickSpec {
    override func spec() {
        
        describe("PeopleRandomizer") {
            let subject = PeopleRandomizerImpl()
            
            describe("#getRandomSubset") {
                let people = [
                    Person(name: "P1", image: "I1"),
                    Person(name: "P2", image: "I2"),
                    Person(name: "P3", image: "I3"),
                ]
                var result: PersonChallenge!
                
                describe("When only one element remains that is not in the avoid set") {
                    beforeEach {
                        result = subject.getRandomSubset(ofSize: 2, from: people, avoiding: [people[0], people[2]])
                    }
                    
                    it("returns the remaining element as the target") {
                        expect(result.peopleChoices[result.target]).to(equal(people[1]))
                    }
                }
            }
        }
    }
}