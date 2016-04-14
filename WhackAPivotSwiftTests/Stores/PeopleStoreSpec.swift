import Foundation
import Quick
import Nimble

@testable import WhackAPivotSwift

class PeopleStoreSpec: QuickSpec {
    override func spec() {
        describe("PeopleStore") {
            let peopleStore = PeopleStoreImpl()
            
            describe("Getting a saved people store") {
                let dummyImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("dummy", ofType: "png")!)!
                let dummyImage2 = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("dummy2", ofType: "png")!)!

                let people = [
                    Person(name: "first person", image: dummyImage, id: 23),
                    Person(name: "second person", image: dummyImage2, id: 42)
                ]
                let newPeopleStore = PeopleStoreImpl()
                
                beforeEach {
                    peopleStore.people = people
                }
                
                it("a new store should return the same people") {
                    expect(newPeopleStore.people).to(equal(people))
                }
            }
        }
    }
}

