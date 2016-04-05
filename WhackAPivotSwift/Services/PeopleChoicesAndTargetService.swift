import Foundation

protocol PeopleChoicesAndTargetService {
    func provide() -> PeopleChoicesAndTarget
}

class PeopleChoicesAndTargetServiceImpl: PeopleChoicesAndTargetService {
    private let peopleRandomizer: PeopleRandomizer
    private let peopleService: PeopleService
    private var people: [Person]?
    private var previouslyTargetedPeople = Set<Person>()
    
    init(peopleService: PeopleService, peopleRandomizer: PeopleRandomizer) {
        self.peopleRandomizer = peopleRandomizer
        self.peopleService = peopleService
    }
    
    func provide() -> PeopleChoicesAndTarget {
        if people == nil {
            people = peopleService.getPeople()
        }
        let peopleChoicesAndTarget = peopleRandomizer.getRandomSubset(ofSize: 6, from: people!, avoiding: previouslyTargetedPeople)
        
        previouslyTargetedPeople.insert(peopleChoicesAndTarget.peopleChoices[peopleChoicesAndTarget.target])
        
        if previouslyTargetedPeople.count == people!.count {
            previouslyTargetedPeople = []
        }
        
        return peopleChoicesAndTarget
    }
}

