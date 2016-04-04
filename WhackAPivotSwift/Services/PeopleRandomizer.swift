import Foundation
import RandomKit

protocol PeopleRandomizer {
    func getRandomSubset(ofSize ofSize: Int, from people: [Person], avoiding peopleToAvoid: Set<Person>) -> PeopleChoicesAndTarget
}

class PeopleRandomizerImpl: PeopleRandomizer {
    func getRandomSubset(ofSize ofSize: Int, from people: [Person], avoiding peopleToAvoid: Set<Person>) -> PeopleChoicesAndTarget {
        let allPeople = Set(people)
        let potentialTargets = allPeople.subtract(peopleToAvoid)
        let targetPerson = Array(potentialTargets)[Int(arc4random_uniform(UInt32(potentialTargets.count)))]
        let remainingPeople = Array(allPeople.subtract([targetPerson]))
        let choices: [Person] = Array([targetPerson] + remainingPeople[0..<(ofSize-1)]).shuffle()
        return PeopleChoicesAndTarget(peopleChoices: choices, target: choices.indexOf(targetPerson)!)
    }
}