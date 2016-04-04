//
//  PeopleChoicesAndTarget.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/1/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

struct PeopleChoicesAndTarget: Equatable {
    let peopleChoices: [Person]
    let target: Int
}

func ==(lhs: PeopleChoicesAndTarget, rhs: PeopleChoicesAndTarget) -> Bool {
    return lhs.peopleChoices == rhs.peopleChoices && lhs.target == rhs.target
}