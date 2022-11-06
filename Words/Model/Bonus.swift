//
//  Bonus.swift
//  Words
//
//  Created by Dasha Palshau on 06.11.2022.
//

import Foundation

enum Bonus: Equatable {
    case multiplyBy(value: Value)
    case add(value: Value)
    
    enum Value: Int {
        case two = 2
        case three = 3
    }
}
