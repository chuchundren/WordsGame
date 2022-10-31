//
//  WordsViewModel.swift
//  Words
//
//  Created by Dasha Palshau on 02.07.2022.
//

import Foundation
import SwiftUI

class WordsViewModel: ObservableObject {
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
        if let wordStr = model.enterWord() {
            Task {
                do {
                    let words = try await api.fetchDefinition(forWord: wordStr)
                    for word in words {
                        if isValidPartOfSpeach(of: word) {
                            DispatchQueue.main.async {
                                self.model.addWord(wordStr, isRealWord: true)
                            }
                            
                            return
                        }
                    }
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.model.addWord(wordStr, isRealWord: false)
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
