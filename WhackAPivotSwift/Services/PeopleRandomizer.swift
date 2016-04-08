import Foundation
import RandomKit

protocol PeopleRandomizer {
    func getRandomSubset(ofSize ofSize: Int, from people: [Person], avoiding peopleToAvoid: Set<Person>) -> PersonChallenge
}

class PeopleRandomizerImpl: PeopleRandomizer {
    func getRandomSubset(ofSize ofSize: Int, from people: [Person], avoiding peopleToAvoid: Set<Person>) -> PersonChallenge {
        
        let allPeople = Set(people)
        
        let potentialTargets = allPeople.subtract(peopleToAvoid)
        
        let targetPerson = Array(potentialTargets)[Int(arc4random_uniform(UInt32(potentialTargets.count)))]
        
        let remainingPeople = Array(allPeople.subtract([targetPerson])).shuffle()
        
        let choices = Array([targetPerson] + remainingPeople[0..<(ofSize-1)]).shuffle()
        
        return PersonChallenge(peopleChoices: choices, target: choices.indexOf(targetPerson)!)
    }
}