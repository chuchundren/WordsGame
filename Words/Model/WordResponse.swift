//
//  WordResponse.swift
//  Words
//
//  Created by Dasha Palshau on 21.10.2022.
//

import Foundation

struct WordResponse: Codable {
    let word: String
    let meanings: [Meaning]
    
    struct Meaning: Codable {
        let partOfSpeech: String
    }
}
