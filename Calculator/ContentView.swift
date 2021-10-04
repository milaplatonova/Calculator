//
//  ContentView.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 3/1/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.clean, .plusMinus, .percentage, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .bottom) {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack (spacing: 12) {
                    HStack {
                        Spacer ()
                        Text(self.env.display)
                            .modifier(TextModifier())
                    }.padding()
                    
                    ForEach(self.buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { button in
                                CalculatorButtonView(button: button)
                            }
                        }
                    }
                    
                }.padding(.bottom)
            }
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
