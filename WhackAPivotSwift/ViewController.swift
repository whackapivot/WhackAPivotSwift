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
    @IBOutlet var personButtons: [UIButton]!
    
    var peopleChoicesAndTargetService: PeopleChoicesAndTargetService!
    
    var peopleChoicesAndTarget: PeopleChoicesAndTarget!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }
    
    private func startNewRound() {
        peopleChoicesAndTarget = peopleChoicesAndTargetService.provide()
        
        for (index, person) in peopleChoicesAndTarget.peopleChoices.enumerate() {
            let personImage = UIImage(named: person.image)
            personButtons[index].setBackgroundImage(personImage, forState: .Normal)
        }
        
        nameLabel.text = peopleChoicesAndTarget.peopleChoices[peopleChoicesAndTarget.target].name
    }
    
    // MARK: Actions
    
    @IBAction func clickedOnButton(button: UIButton) {
        
        let indexOfClickedButton = personButtons.indexOf(button)
        
        if(indexOfClickedButton == peopleChoicesAndTarget.target) {
            startNewRound()
        }
        else {
            resultLabel.text = "Incorrect!"
            resultLabel.hidden = false
        }
        
    }
}
