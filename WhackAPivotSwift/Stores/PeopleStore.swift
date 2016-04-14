import Foundation
import SwiftyJSON

protocol PeopleStore {
    var people: [Person]? { get set }
}

class PeopleStoreImpl: PeopleStore {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as String
    var people: [Person]? {
        get {
            var peopleArray: [Person] = []
            
            do {
                let text = try String(contentsOfFile: pathForPeople(), encoding: NSUTF8StringEncoding)
                let data = text.dataUsingEncoding(NSUTF8StringEncoding)
                let peopleJsonArray = JSON(data: data!)
                for i in (0..<peopleJsonArray.count) {
                    let peopleDict = peopleJsonArray[i]
                    var person = Person(name: peopleDict["name"].stringValue, id: peopleDict["id"].intValue)
                    person.image = UIImage(contentsOfFile: pathForPersonImage(person))!
                    peopleArray += [person]
                }
                self.people = peopleArray
            } catch {
                return nil
            }
            
            return peopleArray
        }
        
        set(newPeople) {
            let peopleArray: [[String:AnyObject]] = newPeople!.map {person -> [String:AnyObject] in
                if let data = UIImagePNGRepresentation(person.image) {
                    let filename = pathForPersonImage(person)
                    data.writeToFile(filename, atomically: true)
                }

                return ["id": NSInteger(person.id), "name": person.name]
            }
            let data: NSData
            do {
                data = try NSJSONSerialization.dataWithJSONObject(peopleArray, options: .PrettyPrinted)
                try data.writeToFile(pathForPeople(), options: .DataWritingFileProtectionNone)
            } catch {
                NSLog("Storing people failed")
            }
        }
    }
    
    private func pathForPersonImage(person: Person) -> String {
        return "\(documentsPath)\(person.id).png"
    }
    private func pathForPeople() -> String {
        return "\(documentsPath)people.json"
    }
}