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
            c.peopleChoicesAndTargetService = r.resolve(PeopleChoicesAndTargetService.self)
        }
        defaultContainer.register(PeopleChoicesAndTargetService.self) { r in
            PeopleChoicesAndTargetServiceImpl(peopleService: r.resolve(PeopleService.self)!, peopleRandomizer: r.resolve(PeopleRandomizer.self)!)
        }
        defaultContainer.register(PeopleService.self) { _ in PeopleServiceImpl() }
        defaultContainer.register(PeopleRandomizer.self) { _ in PeopleRandomizerImpl() }
    }
}
