//
//  WhackAPivotSwiftTests.swift
//  WhackAPivotSwiftTests
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import WhackAPivotSwift

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController") {
            var viewController: ViewController?
            var fakePivotsService: FakePivotsService?
            
            beforeEach { () -> () in
                let container = Container()
                container.registerForStoryboard(ViewController.self) { _, c in
                    fakePivotsService = FakePivotsService()
                    c.pivotsService = fakePivotsService
                }
                
                let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
                viewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as? ViewController
                let _ = viewController!.view
            }
        
            
            it("has a hidden result label") {
                expect(viewController!.resultLabel.hidden).to(beTruthy())
            }
            
            it("calls the PivotsService when being initialized") {
                expect(fakePivotsService!.getPivotsCallCount).to(equal(1))
            }
            
            it("selects a name from the returned pivots and puts it on the nameLabel") {
                expect(fakePivotsService!.pivotNames).to(contain(viewController!.nameLabel.text))
            }
            
            it("picks six different pivots for the six image views") {
                var images = Set<String>()
                
                for imageView in viewController!.imageViews {
                    images.insert(imageView.image.)
                }
                
            }
        }
    }
}

