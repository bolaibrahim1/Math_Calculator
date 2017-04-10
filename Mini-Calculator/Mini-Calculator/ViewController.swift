//
//  ViewController.swift
//  Mini-Calculator
//
//  Created by Bola Ibrahim on 2/16/17.
//  Copyright © 2017 Bola Ibrahim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayScreen: UILabel!
    @IBOutlet weak var descriptionScreen: UILabel!
    
    var showOnLabel: String = " "
    var resultIsPinding = true
    
    var onClick = false
    //this property for write . for decimal numbers
    var decimalPoint = false
    @IBAction func clickOnes(_ sender: UIButton) {
        let digit = sender.currentTitle!
            if onClick {
                if digit == "." && decimalPoint == true{
                    return
                }else if digit == "." && decimalPoint == false{
                    decimalPoint = true
                }
                let textOnDisplay = displayScreen.text!
                displayScreen.text = textOnDisplay + digit
            }
            else{
                displayScreen.text = digit
            }
            onClick = true
        if resultIsPinding {
            showOnLabel = showOnLabel + digit
            descriptionScreen.text = showOnLabel
        }
      
    }
   
    
    //that make convertion from string on the screen into double value to deal with calculations
    var doubleValue: Double {
        get{
            return Double(displayScreen.text!)!
        }
        set{
            displayScreen.text = String(newValue)
        }
    }
    
    //create an instance for calculator model
    var brain = CalculatorBrain()
    
    //perform operators that deal with numbers
    @IBAction func performOperation(_ sender: UIButton) {
        decimalPoint = false
        if onClick{
            brain.setOperand(doubleValue)
            onClick = false
        }
        
        if let symbolMath = sender.currentTitle{
            if symbolMath == "AC"{
                showOnLabel = " "
                descriptionScreen.text = nil
                brain.clear()
                displayScreen.text = "0"
            }else{
            brain.performOperation(symbolMath)
            showOnLabel = showOnLabel + sender.currentTitle!
            descriptionScreen.text = showOnLabel
            resultIsPinding = true
            }
            if symbolMath == "=" {
                showOnLabel = showOnLabel.replacingOccurrences(of: "=", with: "")
            }

            }
        if let result = brain.result{
            doubleValue = result
  
        }

        }
}

    

