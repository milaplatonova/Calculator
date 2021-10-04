//
//  TextModifier.swift
//  Calculator
//
//  Created by Lyudmila Platonova on 3/15/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import Foundation
import SwiftUI

let textWidth = UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 5*12)/4 - 24
let textHeight = UIScreen.main.bounds.size.height - ((UIScreen.main.bounds.width - 5*12)/4)*5 - 7*12 - 72

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 64))
            .minimumScaleFactor(0.2)
            .lineLimit(1)
            .frame(width: textWidth, height: textHeight, alignment: .bottomTrailing)
            .padding(.horizontal)
    }
}
