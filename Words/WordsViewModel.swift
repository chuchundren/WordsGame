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

	init() {}
    
    func formattedTime(from timeInterval: TimeInterval) -> String {
        return formatter.string(from: timeInterval) ?? ""
    }
    
    func selectLetter(row: Int, col: Int) {
       model.selectLetter(row: row, col: col)
    }
    
	func enterWord() {
        model.enterWord()
    }
    
	func endGame() {
        model.endGame()
    }
    
    func startNewGame() {
        model.newGame()
    }

}
