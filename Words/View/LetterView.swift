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
            
            if let bonus = letter.bonus {
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(ThemeManager.shared.accentColor2)
                            Text(label(for: bonus))
                                .foregroundColor(ThemeManager.shared.letterColor)
                        }
                        .frame(width: 24, height: 24, alignment: .topTrailing)
                        Spacer()
                    }
                }
            }
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
    
    private func label(for bonus: Bonus) -> String {
        switch bonus {
        case .multiplyBy(let value):
            return "x\(value.rawValue)"
        case .add(let value):
            return "c\(value.rawValue)"
        }
    }
    
    enum Constants {
        static let rotationDegrees: Double = 3
        static let animationDuration: Double = 0.1
    }
}
