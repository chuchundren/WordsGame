//
//  DictionaryAPI.swift
//  Words
//
//  Created by Dasha Palshau on 21.10.2022.
//

import Foundation

protocol API {
    func fetchDefinition(forWord word: String) async throws -> [WordResponse]
}

final class DictionaryAPI: API {
    
    enum APIError: Error {
        case invalidURL
    }
    
    static let shared = DictionaryAPI()
    
    private init() {}
    
    func fetchDefinition(forWord word: String) async throws -> [WordResponse] {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let words = try JSONDecoder().decode([WordResponse].self, from: data)
        
        return words
    }
    
}
