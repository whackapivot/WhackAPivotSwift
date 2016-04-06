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
        let peopleServiceImpl = PeopleServiceImpl()
        
        defaultContainer.registerForStoryboard(ViewController.self) { r, c in
            c.peopleChoicesAndTargetService = r.resolve(PeopleChoicesAndTargetService.self)
            c.personDisplayer = r.resolve(PersonDisplayer.self)!
        }
        
        defaultContainer.registerForStoryboard(LoginViewController.self) { r, c in
            c.urlProvider = r.resolve(URLProvider.self)
            c.peopleService = r.resolve(PeopleService.self)
        }
        
        defaultContainer.register(PeopleChoicesAndTargetService.self) { r in
            PeopleChoicesAndTargetServiceImpl(
                peopleService: r.resolve(PeopleService.self)!,
                peopleRandomizer: r.resolve(PeopleRandomizer.self)!
            )
        }
        
        defaultContainer.register(PeopleService.self) { _ in peopleServiceImpl }
        defaultContainer.register(PeopleRandomizer.self) { _ in PeopleRandomizerImpl() }
        defaultContainer.register(PersonDisplayer.self) { _ in PersonDisplayerImpl() }
        defaultContainer.register(URLProvider.self) { _ in URLProviderImpl(baseURL: "https://pivots.pivotallabs.com") }
        
    }
}
