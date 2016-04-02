//
//  PeopleChoicesAndTargetProvider.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/1/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

protocol PeopleChoicesAndTargetService {
    func provide() -> PeopleChoicesAndTarget
}

class PeopleChoicesAndTargetServiceImpl: PeopleChoicesAndTargetService {
    private let peopleRandomizer: PeopleRandomizer
    private let people: [Person]
    private var previouslyTargetedPeople = Set<Person>()
    
    init(peopleService: PeopleService, peopleRandomizer: PeopleRandomizer) {
        self.peopleRandomizer = peopleRandomizer
        people = peopleService.getPeople()
    }
    
    func provide() -> PeopleChoicesAndTarget {
        let peopleChoicesAndTarget = peopleRandomizer.getRandomSubset(people, peopleToAvoid: previouslyTargetedPeople)
        
        previouslyTargetedPeople.insert(people[peopleChoicesAndTarget.target])
        
        return peopleChoicesAndTarget
    }
}

