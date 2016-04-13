import Foundation

// this file was generated by Xcode-Better-Refactor-Tools
// https://github.com/tjarratt/xcode-better-refactor-tools

@testable import WhackAPivotSwift
class FakeTokenStore : TokenStore, Equatable {
    init() {
        self.set_tokenArgs = []
    }
    private var _token : Token??
    private var set_tokenArgs : Array<Token?>

    var token : Token? {
        get {
            return _token!
        }

        set {
            _token = newValue
            set_tokenArgs.append(newValue)
        }
    }

    func setTokenCallCount() -> Int {
        return set_tokenArgs.count
    }

    func setTokenArgsForCall(index : Int) throws -> Token? {
        if index < 0 || index >= set_tokenArgs.count {
            throw NSError.init(domain: "swift-generate-fake-domain", code: 1, userInfo: nil)
        }
        return set_tokenArgs[index]
    }

    static func reset() {
    }
}

func == (a: FakeTokenStore, b: FakeTokenStore) -> Bool {
    return a === b
}