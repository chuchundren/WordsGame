//
//  Array+Extension.swift
//  Words
//
//  Created by Dasha Palshau on 28.09.2022.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
