//
//  ViewController.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel! { didSet { resultLabel.hidden = true } }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var imageViews: [UIImageView]!
    
    var pivotsService: PivotsService!
    
    private var pivots = [Pivot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pivots = pivotsService.getPivots()
        nameLabel.text = pivots[0].name
    }
}
