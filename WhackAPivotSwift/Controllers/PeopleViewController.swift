import UIKit

class PeopleViewController: UIViewController {
    var peopleService: PeopleService!
    var peopleStore: PeopleStore!
    var seguePerformed = false
    var popPerformed = false
    
    override func viewDidAppear(animated: Bool) {
        let promise = peopleService.getPeople()
        promise.future.then { people in
            self.peopleStore.people = people
            self.performSegue()
            }.error { error in
                self.popToRootController()
        }
    }
    
    private func performSegue() {
        seguePerformed = true
        performSegueWithIdentifier("GameViewController", sender: self)
    }
    
    private func popToRootController() {
        popPerformed = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
