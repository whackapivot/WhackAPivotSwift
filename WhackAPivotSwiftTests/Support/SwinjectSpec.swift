//
//  SwinjectSpec.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/25/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Quick
import Swinject

class SwinjectSpec: QuickSpec {
    let testContainer = Container()
    
    func startController(controllerName: String, storyboardName: String) -> UIViewController {
        let storyboard = SwinjectStoryboard.create(name: storyboardName, bundle: nil, container: testContainer)
        let controller = storyboard.instantiateViewControllerWithIdentifier(controllerName)
        let _ = controller.view
        return controller
    }
}
