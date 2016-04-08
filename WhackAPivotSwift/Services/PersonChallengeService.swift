import Foundation

protocol PersonChallengeService {
    func startNewGame(people: [Person], peoplePerChallenge: Int)
    func getChallenge() -> PersonChallenge?
}

class PersonChallengeServiceImpl: PersonChallengeService {
    private let peopleRandomizer: PeopleRandomizer
    var previouslyTargetedPeople = Set<Person>()
    var peoplePerChallenge: Int!
    var people: [Person]!
    
    init(peopleRandomizer: PeopleRandomizer) {
        self.peopleRandomizer = peopleRandomizer
    }
    
    func startNewGame(people: [Person], peoplePerChallenge: Int) {
        self.people = people
        self.peoplePerChallenge = peoplePerChallenge
    }
    
    func getChallenge() -> PersonChallenge? {
        if previouslyTargetedPeople.count == people.count {
            return nil
        }

        let personChallenge = peopleRandomizer.getRandomSubset(ofSize: peoplePerChallenge, from: people, avoiding: previouslyTargetedPeople)
        
        previouslyTargetedPeople.insert(personChallenge.peopleChoices[personChallenge.target])

        
        return personChallenge
    }
}

