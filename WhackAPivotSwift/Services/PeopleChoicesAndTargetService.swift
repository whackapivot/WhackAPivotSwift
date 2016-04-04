import Foundation

protocol PeopleChoicesAndTargetService {
    func provide() -> PeopleChoicesAndTarget
}

class PeopleChoicesAndTargetServiceImpl: PeopleChoicesAndTargetService {
    private let peopleRandomizer: PeopleRandomizer
    private let people: [Person]
    private var previouslyTargetedPeople = Set<Person>()
    
    init(peopleService: PeopleService, peopleRandomizer: PeopleRandomizer) {
        people = peopleService.getPeople()
        self.peopleRandomizer = peopleRandomizer
    }
    
    func provide() -> PeopleChoicesAndTarget {
        let peopleChoicesAndTarget = peopleRandomizer.getRandomSubset(ofSize: 6, from: people, avoiding: previouslyTargetedPeople)
        
        previouslyTargetedPeople.insert(peopleChoicesAndTarget.peopleChoices[peopleChoicesAndTarget.target])
        
        if previouslyTargetedPeople.count == people.count {
            previouslyTargetedPeople = []
        }
        
        return peopleChoicesAndTarget
    }
}

