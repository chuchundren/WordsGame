//
//  Theme.swift
//  Words
//
//  Created by Dasha Palshau on 28.09.2022.
//

import SwiftUI

enum Theme: Int {
    case light, dark, pastel, brightPastel
}

class ThemeManager {
    static let shared = ThemeManager()
    
    var currentTheme: Theme = .light
    
    var background: Color {
        switch currentTheme {
        case .light:
            return Color(red: 0.99, green: 0.99, blue: 0.98)
        case .dark:
            return Color(red: 0.11, green: 0.11, blue: 0.11)
        case .pastel:
            return Color(red: 0.93, green: 0.94, blue: 0.92)
        case .brightPastel:
            return Color(red: 0.02, green: 0.08, blue: 0.50)
        }
    }
    
    var baseColor: Color {
        switch currentTheme {
        case .light:
            return Color(red: 0.87, green: 0.93, blue: 0.95)
        case .dark:
            return Color(red: 0.89, green: 0.42, blue: 0.29)
            //Color(red: 0.42, green: 0.55, blue: 0.89)
        case .pastel:
            return  Color(red: 0.71, green: 0.82, blue: 0.74)
            //Color(red: 0.76, green: 0.80, blue: 0.74)
        case .brightPastel:
            return Color(red: 0.96, green: 0.78, blue: 0.85)
        }
    }
    
    var accentColor: Color {
        switch currentTheme {
        case .light:
            return Color(red: 0.97, green: 0.86, blue: 0.48)
        case .dark:
            return Color(red: 1.00, green: 0.84, blue: 0.29)
        case .pastel:
            return Color(red: 0.90, green: 0.87, blue: 0.78)
        case .brightPastel:
            return Color(red: 0.97, green: 0.97, blue: 0.97)
        }
    }
    
    var textColor: Color {
        switch currentTheme {
        case .light:
            return Color(red: 0.09, green: 0.11, blue: 0.27)
        case .dark:
            return Color(red: 0.89, green: 0.42, blue: 0.29)
        case .pastel:
            return Color.black
        case .brightPastel:
            return Color(red: 0.96, green: 0.78, blue: 0.85)
        }
    }
    
    var letterColor: Color {
        switch currentTheme {
        case .light:
            return Color(red: 0.09, green: 0.11, blue: 0.27)
        case .dark:
            return Color(red: 0.11, green: 0.11, blue: 0.11)
        case .pastel:
            return Color.black
        case .brightPastel:
            return Color(red: 0.02, green: 0.08, blue: 0.50)
        }
    }
    
}
