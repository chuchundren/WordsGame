//
//  Animation+extensions.swift
//  Words
//
//  Created by Dasha Palshau on 24.09.2022.
//

import SwiftUI

extension Animation {
    func repeatWhile(_ expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
