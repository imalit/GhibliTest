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
let totalList = [Animal(name: "Cat"), Animal(name: "Dog")]
var list = [Animal]()
for index in 0..<totalList.count {
    list.append(totalList[index])
}

print(list)

