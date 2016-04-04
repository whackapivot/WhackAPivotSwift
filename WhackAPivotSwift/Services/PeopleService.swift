//
//  PivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation
import UIKit

protocol PeopleService {
    func getPeople() -> [Person]
}

class PeopleServiceImpl: PeopleService {
    func getPeople() -> [Person] {
        return Range(0...40).map { i in Person(name: "\(i)", image: "\(i)") }
    }
}
