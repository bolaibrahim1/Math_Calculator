//: Playground - noun: a place where people can play

import UIKit

//$$$$$$$$$$$$$ -- Collection types -- $$$$$$$$$$$$$$$
// *********the first type is dictionaries

var numbers = [Int : String]()
print(numbers)

numbers [1] = "one"
numbers [2] = "two"
print(numbers)

numbers = [:]
print(numbers)

var number = [1:"one",2:"two",3:"three",4:"four"]
number.count
number.isEmpty
number[5]="five"
print(number)


