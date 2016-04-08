import Foundation
import UIKit

struct Person : Hashable {
    var name: String
    var image: UIImage
    
    var hashValue: Int {
        get {
            return name.hashValue
        }
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.image == rhs.image
}
