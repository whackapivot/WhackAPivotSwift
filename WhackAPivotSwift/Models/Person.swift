import Foundation
import UIKit

struct Person : Hashable {
    var id: Int = 0
    var name: String
    var image: UIImage = UIImage()
    
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    var hashValue: Int {
        get {
            return name.hashValue
        }
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.image == rhs.image
}
