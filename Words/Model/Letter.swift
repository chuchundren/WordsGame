//
//  Letter.swift
//  Words
//
//  Created by Dasha Palshau on 25.08.2022.
//

import Foundation

struct Letter: Identifiable {
    
    let id = UUID()
    let value: Character
    let row: Int
    let col: Int
    
    var bonus: Bonus?
    var isSelected = false
    
    init(_ value: Character, row: Int, col: Int) {
        self.value = value
        self.row = row
        self.col = col
    }
}
