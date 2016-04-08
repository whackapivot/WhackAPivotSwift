import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel! { didSet { resultLabel.hidden = true } }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var personButtons: [UIButton]!
    
    var peopleStore: PeopleStore!
    var personChallengeService: PersonChallengeService!
    var personDisplayer: PersonDisplayer!
    var people: [Person]!
    var gameEnded = false
    
    let numPeoplePerChallenge = 6
    
    private var personChallenge: PersonChallenge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        people = peopleStore.people
        startNewGame()
    }
    
    private func startChallenge() {
        personChallenge = personChallengeService.getChallenge()
        guard personChallenge != nil  else {
            handleEndOfGame()
            return
        }
        for (index, person) in personChallenge.peopleChoices.enumerate() {
            personDisplayer!.display(person, button: personButtons[index])
        }
        nameLabel.text = personChallenge.peopleChoices[personChallenge.target].name
    }
    
    private func handleEndOfGame() {
        gameEnded = true
    }
    
    private func startNewGame() {
        self.personChallengeService.startNewGame(people!, peoplePerChallenge: self.numPeoplePerChallenge)
        startChallenge()
    }
    
    // MARK: Actions
    
    @IBAction func clickedOnButton(button: UIButton) {
        guard !gameEnded else { return }
        let indexOfClickedButton = personButtons.indexOf(button)
        
        if(indexOfClickedButton == personChallenge.target) {
            resultLabel.hidden = true
            startChallenge()
        }
        else {
            resultLabel.text = "Incorrect!"
            resultLabel.hidden = false
        }
        
    }
}
