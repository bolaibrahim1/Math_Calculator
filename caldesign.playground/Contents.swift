import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    @IBOutlet weak var changeSignButton: UIButton!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var userInsertedADot: Bool = false
    let brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        addToHistory(digit)
    }
    
    
    @IBAction func appendDot() {
        if !userInsertedADot && userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + "."
            userInsertedADot = true
            addToHistory(".")
        }
        if !userInsertedADot && !userIsInTheMiddleOfTypingANumber {
            display.text =  "."
            userInsertedADot = true
            userIsInTheMiddleOfTypingANumber = true
            addToHistory(".")
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            addToHistory(operation)
        }
        
        
    }
    
    @IBAction func clear() {
        
        display.text = "0"
        history.text = " "
        brain.clearOperationStack()
        
        userIsInTheMiddleOfTypingANumber = false
        userInsertedADot = false
        
    }
    
    
    @IBAction func undo() {
        
        if count(display.text!) > 1 {
            display.text = dropLast(display.text!)
        }else{
            display.text = "0"
        }
    }
    
    @IBAction func changeSign() {
        if userIsInTheMiddleOfTypingANumber {
            if Array(display.text!)[0] == "-" {
                display.text = dropFirst(display.text!)
            }else {
                display.text = "-" + display.text!
            }
        }else {
            operate(changeSignButton)
        }
        
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userInsertedADot = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        addToHistory(" ")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    
    
    func addToHistory(recordToAddToHistory: String) {
        history.text = history.text! + recordToAddToHistory
    }
    
}
CalculatorBrain.swift:

import Foundation

class CalculatorBrain {
    
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case EmptyOperation(String, Double)
        
        var description: String {
            get {
                switch self {
                case Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .EmptyOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init() {
        
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷"){$1 / $0})
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") {$1 - $0})
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.EmptyOperation("π", M_PI))
        learnOp(Op.UnaryOperation("±"){-$0})
        
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .EmptyOperation(_, let operation):
                return (operation, remainingOps)
            }
        }
        
        return (nil, ops)
        
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        
        opStack.append(Op.Operand(operand))
        
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
    func clearOperationStack(){
        opStack = [Op]()
    }
    
}
