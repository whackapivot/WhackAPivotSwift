import UIKit

class PeopleViewController: UIViewController {
    var peopleService: PeopleService!
    var peopleStore: PeopleStore!
    var segueToPeoplePerformed = false
    var segueToLoginPerformed = false
    
    override func viewDidAppear(animated: Bool) {
        let promise = peopleService.getPeople()
        promise.future.then { people in
            self.peopleStore.people = people
            dispatch_async(dispatch_get_main_queue()) {
                self.segueToPeople()
            }
            }.error { error in
                self.segueToLogin()
        }
    }
    
    private func segueToPeople() {
        segueToPeoplePerformed = true
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("GameViewController", sender: self)
        }
    }
    
    private func segueToLogin() {
        segueToLoginPerformed = true
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("ReturnToLogin", sender: self)
        }
    }
}
