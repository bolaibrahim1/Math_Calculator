//: Playground - noun: a place where people can play

import UIKit

//$$$$$$$$$$$$$ -- Collection types -- $$$$$$$$$$$$$$$
// *********the first type is Sets 

var letters = Set<Character>()
print(letters)

letters = ["a","c","b"]
print(letters)

letters = []
print(letters)
var _letters : Set<Int> = []
_letters = [1,2,6,4,3,0,5]

_letters.insert(8)

_letters.count
_letters.isEmpty
_letters.remove(0)
print(_letters)
_letters.count
_letters.sort()

_letters.contains(7)

for x in _letters {
    print(x)
}


var b : Set = [1,5,3,6,3,2]
var a : Set = [1,6,7,3,7,2]

a.intersect(b)
a.union(b)
a.subtract(b)
a.exclusiveOr(b)

