//
//  CalculatorModel.swift
//  Mini-Calculator
//
//  Created by Bola Ibrahim on 3/25/17.
//  Copyright © 2017 Bola Ibrahim. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
//    private var description: String = ""
//    private var resultIsPending = true
    
    private enum  OperationsEnum {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOPeration((Double,Double)-> Double)
        case equal
    }
   
    private var operation: Dictionary<String,OperationsEnum> = [
        "π" : OperationsEnum.constant(M_PI),
        "e" : OperationsEnum.constant(M_E),
        "√" : OperationsEnum.unaryOperation(sqrt),
        "±" : OperationsEnum.unaryOperation({-$0}),
        "+" : OperationsEnum.binaryOPeration({$0+$1}),
        "÷" : OperationsEnum.binaryOPeration({$0/$1}),
        "−" : OperationsEnum.binaryOPeration({$0-$1}),
        "cos" : OperationsEnum.unaryOperation(cos),
        "sin" : OperationsEnum.unaryOperation(sin),
        "tan" : OperationsEnum.unaryOperation(tan),
        "AC" :OperationsEnum.constant(0.0),
        "×" : OperationsEnum.binaryOPeration({$0*$1}),
        "=" : OperationsEnum.equal
    ]
    
    mutating func performOperation(_ symobl: String){
        if let operation = operation[symobl]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                accumulator = function(accumulator!)
                }
            case .binaryOPeration(let function):
                if accumulator != nil {
                    makeBinaryOperation = MakeBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equal:
                performBinaryOperation()
            }
        }
    }
    
    private mutating func performBinaryOperation(){
        if makeBinaryOperation != nil && accumulator != nil {
            accumulator = makeBinaryOperation!.perform(with: accumulator!)
            makeBinaryOperation = nil
        }
    }
    
    private var makeBinaryOperation : MakeBinaryOperation?
    
//    private var description: String {
//        return
//    }
    
    private struct MakeBinaryOperation{
        let function: (Double,Double)-> Double
        let firstOperand: Double
        
        func  perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func  setOperand(_ operand: Double) {
        accumulator = operand
//        while resultIsPending {
//            description = description + String(operand)
//            resultIsPending = false
//        }
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
    mutating func clear(){
        accumulator = 0.0
    }
}
