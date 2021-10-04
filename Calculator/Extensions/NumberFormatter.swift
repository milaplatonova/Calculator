//
//  NumberFormatter.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 6/1/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import Foundation

extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = false
        formatter.decimalSeparator = ","
        return formatter
    }()
    
}


extension NSDecimalNumber {
    
    struct Number {
        static var formatter = NumberFormatter()
    }
    
    var scientificStyle: String {
        Number.formatter.numberStyle = .scientific
        Number.formatter.positiveFormat = "0.#####E0"
        Number.formatter.negativeFormat = "-0.#####E0"
        Number.formatter.exponentSymbol = "e"
        return Number.formatter.string(from: self) ?? description
    }
    
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
        
    }
    
    func negative() -> NSDecimalNumber {
        return self.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true));
    }
    
}
