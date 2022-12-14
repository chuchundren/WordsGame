//
//  WordsViewModel.swift
//  Words
//
//  Created by Dasha Palshau on 02.07.2022.
//

import Foundation
import SwiftUI

final class WordsViewModel: ObservableObject {
	@Published private var model = WordsGame()
    
    private var api: API
    
    lazy private var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

	var grid: [[Letter]] {
		model.grid
	}
    
    var enteredWord: String {
        model.selectedLetters.map { String($0.value) }.reduce("", +)
    }
    
    var score: String {
        "Score: \(model.score)"
    }
    
    var scoreValue: Int {
        model.score
    }
    
    var foundWords: [String] {
        model.foundWords
            .sorted(by: { $0.count < $1.count} )
    }
    
    init(api: API = DictionaryAPI.shared) {
        self.api = api
    }
    
    func formattedTime(from timeInterval: TimeInterval) -> String {
        return formatter.string(from: timeInterval) ?? ""
    }
    
    func selectLetter(row: Int, col: Int) {
        model.selectLetter(row: row, col: col)
    }
    
    func enterWord()  {
        let result = model.enterWord()
        if let wordStr = result.0, let score = result.1 {
            Task {
                do {
                    let words = try await api.fetchDefinition(forWord: wordStr)
                    for word in words {
                        if isValidPartOfSpeach(of: word) {
                            DispatchQueue.main.async {
                                self.model.addWord(wordStr, isRealWord: true, score: score)
                            }
                            
                            return
                        }
                    }
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.model.addWord(wordStr, isRealWord: false, score: nil)
                }
            }
        }
    }
    
    func endGame() {
        model.endGame()
    }
    
    func startNewGame() {
        model.newGame()
    }
    
    private func isValidPartOfSpeach(of word: WordResponse) -> Bool {
        for meaning in word.meanings {
            if meaning.partOfSpeech == "noun" ||
                meaning.partOfSpeech == "adverb" ||
                meaning.partOfSpeech == "verb" {
                return true
            }
        }
        
        return false
    }

}
