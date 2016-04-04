//
//  PeopleRandomizer.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/1/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

protocol PeopleRandomizer {
    func getRandomSubset(people: [Person], peopleToAvoid: Set<Person>) -> PeopleChoicesAndTarget
}

class PeopleRandomizerImpl: PeopleRandomizer {
    func getRandomSubset(people: [Person], peopleToAvoid: Set<Person>) -> PeopleChoicesAndTarget {
        return PeopleChoicesAndTarget(peopleChoices:
            [
                people[0],
                people[1],
                people[2],
                people[3],
                people[4],
                people[5],
            ],
            target: Int(arc4random_uniform(6)))
    }
    
}