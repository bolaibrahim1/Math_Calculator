//: Playground - noun: a place where people can play

import UIKit
//$$$$$$$$$$$$$ -- Collection types -- $$$$$$$$$$$$$$$
// *********the first type is array
var someInt = [Int]()
print(someInt)

someInt.append(34)
print(someInt)

someInt.append(44)
print(someInt)

someInt = []
print(someInt)

var threeNumbers = [Double](count: 3, repeatedValue: 5)
var fourNumbers = [Double](count: 4, repeatedValue: 3)

var seven = threeNumbers + fourNumbers
var family : [String] = ["Bola","Ayad","Makram"]
//or 
var _family = ["Bola","Ayad","Makram"]
print(family.count)

if family.isEmpty {
    print("true")
}else{
    print(false)
}

family.append("lola")

family += ["Samira"]

var f_item = family[0]

family.insert("suzan", atIndex: 3)

let x = family.removeAtIndex(4)
family.removeLast()

print(family)

for b in family {
    print(b)
}













