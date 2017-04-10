//: Playground - noun: a place where people can play

import UIKit



//polymorphism
//protocol 
//encapsulation ---> public, private, internal
//fuction override --> self, override, super
//inheritance form super class 
//intialization constructor with parameter and without parameter






class Phone {
    
    //property
    var name: String?
    var model: Int?
    var type: String?
    var haveDualSim: Bool?
    var haveCardMemory: Bool?
    
    //methods
    
    func getPrice() -> Double {
        let price = model! + 100
        return Double(price)
    }
    
    func getOwner(n1: String) -> String {
        return n1
    }
    
    init(name: String, model: Int, type: String) {
        self.name = name
        self.model = model
        self.type = type
        print("init with parameter")
    }
    
    init() {
        print("init without parameter")
    }
}

//new inhrietance class
class Samsung: Phone{
    //new methods
    override func getPrice() -> Double {
        let price = model! + 200
        return Double(price)
    }
    
}

let phone1 = Phone(name: "sony", model: 2015, type: "xperia")
phone1.getOwner(n1: "Bola")
phone1.getPrice()

let phone2 = Phone()
phone2.getOwner(n1: "Makram")