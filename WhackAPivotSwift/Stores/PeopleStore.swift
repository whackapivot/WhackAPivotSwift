import Foundation

protocol PeopleStore {
    var people: [Person]? { get set }
}

class PeopleStoreImpl: PeopleStore {
    var people: [Person]?
}