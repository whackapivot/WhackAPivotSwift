import Foundation

// this file was generated by Xcode-Better-Refactor-Tools
// https://github.com/tjarratt/xcode-better-refactor-tools

@testable import WhackAPivotSwift

class FakePeopleRandomizer : PeopleRandomizer {
    init() {
    }

    private(set) var getRandomSubsetCallCount : Int = 0
    var getRandomSubsetStub : ((Int, [Person], Set<Person>) -> (PeopleChoicesAndTarget
))?
    private var getRandomSubsetArgs : Array<(Int, [Person], Set<Person>)> = []
    func getRandomSubsetReturns(stubbedValues: (PeopleChoicesAndTarget
)) {
        self.getRandomSubsetStub = {(ofSize: Int, from: [Person], avoiding: Set<Person>) -> (PeopleChoicesAndTarget
) in
            return stubbedValues
        }
    }
    func getRandomSubsetArgsForCall(callIndex: Int) -> (Int, [Person], Set<Person>) {
        return self.getRandomSubsetArgs[callIndex]
    }
    func getRandomSubset(ofSize ofSize: Int, from: [Person], avoiding: Set<Person>) -> (PeopleChoicesAndTarget
) {
        self.getRandomSubsetCallCount++
        self.getRandomSubsetArgs.append((ofSize, from, avoiding))
        return self.getRandomSubsetStub!(ofSize, from, avoiding)
    }

    static func reset() {
    }
}