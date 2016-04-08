//
//  PersonChallenge.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/1/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

struct PersonChallenge: Equatable {
    let peopleChoices: [Person]
    let target: Int
}

func ==(lhs: PersonChallenge, rhs: PersonChallenge) -> Bool {
    return lhs.peopleChoices == rhs.peopleChoices && lhs.target == rhs.target
}