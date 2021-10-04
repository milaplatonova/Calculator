//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 3/1/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine, dot
    case equal, plus, minus, multiplication, division
    case clean, plusMinus, percentage
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .dot: return ","
        case .equal: return "="
        case .plus: return "+"
        case .minus: return "−"
        case .multiplication: return "✕"
        case .division: return "÷"
        case .plusMinus: return "+/−"
        case .percentage: return "%"
        default: return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return Color(.darkGray)
        case .clean, .plusMinus, .percentage:
            return Color(.lightGray)
        default:
            return Color(.gray)
        }
    }
    
}
