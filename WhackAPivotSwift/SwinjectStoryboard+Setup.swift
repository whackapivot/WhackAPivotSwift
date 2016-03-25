//
//  SwinjectStoryboard+Setup.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Swinject

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.registerForStoryboard(ViewController.self) { r, c in
            c.pivotsService = r.resolve(PivotsService.self)
        }
        defaultContainer.register(PivotsService.self) { _ in PivotsServiceImpl() }
    }
}
