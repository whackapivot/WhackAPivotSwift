//
//  FakePivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation
@testable import WhackAPivotSwift

class FakePivotsService: PivotsService {
    
    let pivots = [
        Pivot(name: "Joe", image: "Joe image"),
        Pivot(name: "Pete", image: "Pete image"),
        Pivot(name: "George", image: "George image"),
        Pivot(name: "Sue", image: "Sue image"),
        Pivot(name: "Mary", image: "Mary image"),
        Pivot(name: "Alan", image: "Alan image"),
        Pivot(name: "Teri", image: "Teri image"),
        Pivot(name: "Phil", image: "Phil image")
    ]
    
    let pivotNames: [String]
    
    var getPivotsCallCount: Int = 0
    
    init() {
        pivotNames = pivots.map {p in p.name}
    }
    
    func getPivots() -> [Pivot] {
        getPivotsCallCount++
        return pivots
    }
}