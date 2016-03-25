//
//  PivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

protocol PivotsService {
    func getPivots() -> [Pivot]
}

class PivotsServiceImpl: PivotsService {
    func getPivots() -> [Pivot] {
        return [];
    }
}
