//
//  PivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

protocol PeopleService {
    func getPeople() -> [Person]
}

class PeopleServiceImpl: PeopleService {
    func getPeople() -> [Person] {
        return [
            Person(name: "Joseph Greubel", image: "CasualPic2015.jpg"),
            Person(name: "Peter Alfvin", image: "DSC00587.jpg"),
            Person(name: "JG Blue", image: "CasualPic2015.jpg"),
            Person(name: "JG Orange", image: "CasualPic2015.jpg"),
            Person(name: "PA Green", image: "DSC00587.jpg"),
            Person(name: "PA Red", image: "DSC00587.jpg"),
        ]
    }
}
