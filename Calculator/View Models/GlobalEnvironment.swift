//
//  GlobalEnvironment.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 3/1/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import SwiftUI

class GlobalEnvironment: ObservableObject {
    
    @Published var display = GlobalEnvironment.defaultDisplay
    
    static let defaultDisplay = "0"
    
    var pressedOperator = ""
    var firstExpression = ""
    var secondExpression = ""
    var result: NSDecimalNumber = 0
    
    func cleanString (_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: ".")
    }
    
    func updateExpression (_ display: String) -> String {
        if display.contains(",") || display.contains(".") {
            return display.replacingOccurrences(of: ".", with: ",")
        } else {
            let number = NSDecimalNumber(string: display)
            return number.formattedWithSeparator
        }
    }
    
    func getResult (firstExpression: String, secondExpression: String, pressedOperator: String) -> NSDecimalNumber {
        let first = NSDecimalNumber(string: cleanString(firstExpression))
        let second = NSDecimalNumber(string: cleanString(secondExpression))
        if pressedOperator == "+" {
            return first.adding(second)
        } else if pressedOperator == "−" {
            return first.subtracting(second)
        } else if pressedOperator == "✕" {
            return first.multiplying(by: second)
        } else if pressedOperator == "÷" && second == 0 {
            return 0
        } else if pressedOperator == "÷" {
            return first.dividing(by: second)
        }
        return 0
    }
    
    
    func displayResult (_ result: NSDecimalNumber) -> String {
        let second = Double(cleanString(secondExpression)) ?? 0
        if second == 0.0 && pressedOperator == "÷" {
            return "Error"
        } else if String(abs(Int32(truncating: result))).replacingOccurrences(of: ".", with: "").count > 9 {
            return result.scientificStyle
        } else {
            return result.formattedWithSeparator
        }
    }
    
    
    func receiveInput (button: CalculatorButton) {
        
        if button.title == "AC" {
            display = GlobalEnvironment.defaultDisplay
            firstExpression = ""
            secondExpression = ""
            pressedOperator = ""
            return
        }
        
        if button.title == "−" && display == GlobalEnvironment.defaultDisplay {
            pressedOperator = button.title
            firstExpression = GlobalEnvironment.defaultDisplay
            return
        } else if button.title == "+" || button.title == "−" || button.title == "✕" || button.title == "÷" {
            if secondExpression.isEmpty {
                pressedOperator = button.title
                return
            } else {
                result = getResult(firstExpression: firstExpression, secondExpression: secondExpression, pressedOperator: pressedOperator)
                firstExpression = String(result.stringValue)
                display = displayResult(result)
                pressedOperator = button.title
                secondExpression = ""
                return
            }
        }
        
        if button.title == "+/−" {
            result = NSDecimalNumber(string: cleanString(firstExpression)).negative()
            firstExpression = String(result.stringValue)
            display = displayResult(result)
            return
        }
        
        if button.title == "%" {
            let first = NSDecimalNumber(string: cleanString(firstExpression))
            if secondExpression.isEmpty {
                result = first.dividing(by: 100)
                firstExpression = String(result.stringValue)
                display = displayResult(result)
                return
            } else {
                let second = NSDecimalNumber(string: cleanString(secondExpression))
                if pressedOperator == "✕" || pressedOperator == "÷" {
                    secondExpression = second.dividing(by: 100).stringValue
                } else {
                    secondExpression = first.multiplying(by: second).dividing(by: 100).stringValue
                }
                result = getResult(firstExpression: firstExpression, secondExpression: secondExpression, pressedOperator: pressedOperator)
                firstExpression = String(result.stringValue)
                display = displayResult(result)
                secondExpression = ""
                pressedOperator = ""
                return
            }
        }
        
        if button.title == "=" {
            result = getResult(firstExpression: firstExpression, secondExpression: secondExpression, pressedOperator: pressedOperator)
            firstExpression = String(result.stringValue)
            display = displayResult(result)
            secondExpression = ""
            pressedOperator = ""
            return
        }
        
        if pressedOperator.isEmpty {
            
            if button.title == "," {
                if display == GlobalEnvironment.defaultDisplay || display == displayResult(result) {
                    display = GlobalEnvironment.defaultDisplay + button.title
                    firstExpression = display
                } else if display.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "").count >= 9 || display.contains(",") {
                    return
                } else {
                    firstExpression += button.title
                    display += button.title
                }
                
            } else if button.title != "," {
                if display == GlobalEnvironment.defaultDisplay || display == displayResult(result) {
                    firstExpression = button.title
                    display = button.title
                } else if display.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "").count >= 9 {
                    return
                } else {
                    firstExpression += button.title
                    if display.contains(",") {
                        display += button.title
                    } else {
                        display = updateExpression(firstExpression)
                    }
                }
            }
            
        } else if secondExpression.isEmpty {
            if button.title == "," {
                display = GlobalEnvironment.defaultDisplay + button.title
                secondExpression = display
            } else if button.title != "," {
                secondExpression = button.title
                display = button.title
            }
            
        } else if !secondExpression.isEmpty && button.title == "," {
            if display.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "").count >= 9 || display.contains(",") {
                return
            } else {
                secondExpression += button.title
                display += button.title
            }
            
        } else if !secondExpression.isEmpty && button.title != "," {
            if display.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "").count >= 9 {
                return
            } else {
                secondExpression += button.title
                if display.contains(",") {
                    display += button.title
                } else {
                    display = updateExpression(secondExpression)
                }
            }
        }
        
    }
}
