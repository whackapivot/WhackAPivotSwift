import Foundation
import UIKit

struct Person : Hashable {
    var id: Int = 0
    var name: String
    var image: UIImage = UIImage()
    
    init(name: String, id: Int = 0, image: UIImage = UIImage()) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    var hashValue: Int {
        get {
            return "\(id)\(name)".hashValue
        }
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.image == rhs.image && lhs.id == rhs.id
}
