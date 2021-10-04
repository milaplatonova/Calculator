//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 3/1/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import SwiftUI

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            self.env.receiveInput(button: self.button)
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5*12)/4, alignment: .center)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
        }
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return ((UIScreen.main.bounds.width - 4*12)/4*2 + 4)
        } else {
            return (UIScreen.main.bounds.width - 5*12)/4
        }
    }
}
