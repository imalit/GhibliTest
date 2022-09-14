import UIKit
import Combine

//struct AnimalIterator: IteratorProtocol {
//    typealias Element = Animal
//    let animals: Animal
//    var current: Int
//
//    init(_ current: Int) {
//        current = current
//    }
//
//    mutating func next() -> Animal? {
//        animalList.
//    }
//}

struct Animal {
    let name: String
}

//extension Animal: Sequence {
//    typealias Element = Animal
//
//    func makeIterator() -> AnimalIterator {
//        return AnimalIterator(start)
//    }
//}

let animalDog = Animal(name: "Dog")
let animalCat = Animal(name: "Cat")

let totalList = [animalDog, animalCat]
print(totalList[0])

var limitedList : [Animal] = []
limitedList.insert(totalList[0], at: 0)
//limitedList[0] = totalList[0]
print(limitedList[0])

