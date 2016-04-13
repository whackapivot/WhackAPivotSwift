import Foundation

// this file was generated by Xcode-Better-Refactor-Tools
// https://github.com/tjarratt/xcode-better-refactor-tools

@testable import WhackAPivotSwift

class FakePeopleStore : PeopleStore, Equatable {
    init() {
        self.set_peopleArgs = []
    }
    private var _people : [Person]??
    private var set_peopleArgs : Array<[Person]?>

    var people : [Person]? {
        get {
            return _people!
        }

        set {
            _people = newValue
            set_peopleArgs.append(newValue)
        }
    }

    func setPeopleCallCount() -> Int {
        return set_peopleArgs.count
    }

    func setPeopleArgsForCall(index : Int) throws -> [Person]? {
        if index < 0 || index >= set_peopleArgs.count {
            throw NSError.init(domain: "swift-generate-fake-domain", code: 1, userInfo: nil)
        }
        return set_peopleArgs[index]
    }

    static func reset() {
    }
}

func == (a: FakePeopleStore, b: FakePeopleStore) -> Bool {
    return a === b
}