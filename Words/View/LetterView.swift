//
//  LetterView.swift
//  Words
//
//  Created by Dasha Palshau on 24.09.2022.
//

import SwiftUI

struct LetterView: View {
    var letter: Letter
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(letter.isSelected ? ThemeManager.shared.accentColor : ThemeManager.shared.baseColor)
                .animation(nil, value: letter.isSelected)
            Text(String(letter.value))
                .font(.system(size: 40))
                .foregroundColor(ThemeManager.shared.letterColor)
        }
        .rotationEffect(Angle(degrees: letter.isSelected ? Constants.rotationDegrees : 0))
        .animation(
            .linear(duration: Constants.animationDuration)
            .repeatWhile(letter.isSelected)
            .delay(Constants.animationDuration),
            value: letter.isSelected
        )
        .rotationEffect(Angle(degrees: letter.isSelected ? -Constants.rotationDegrees : 0))
        .animation(
            .linear(duration: Constants.animationDuration)
            .repeatWhile(letter.isSelected),
            value: letter.isSelected
        )

        .aspectRatio(1, contentMode: .fit)
    }
    
    enum Constants {
        static let rotationDegrees: Double = 3
        static let animationDuration: Double = 0.1
    }
}
