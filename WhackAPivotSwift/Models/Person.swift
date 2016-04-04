//
//  Pivot.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

struct Person : Hashable {
    var name: String
    var image: String
    
    var hashValue: Int {
        get {
            return name.hashValue
        }
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.image == rhs.image
}
