//
//  WordsGame.swift
//  Words
//
//  Created by Dasha Palshau on 02.07.2022.
//

import Foundation

struct WordsGame {
    private let lettersWithFrequenciesRus: [(char: Character, freq: Float)] = [("а", 7.998), ("б", 1.592), ("в", 4.533), ("г", 1.687), ("д", 2.977), ("е", 8.496), ("ж", 0.94), ("з", 1.641), ("и", 7.367), ("й", 1.208), ("к", 3.486), ("л", 4.343), ("м", 3.203), ("н", 6.7), ("о", 10.983), ("п", 2.804), ("р", 4.746), ("с", 5.473), ("т", 6.318), ("у", 2.615), ("ф", 0.267), ("х", 0.966), ("ц",0.486 ), ("ч", 1.45), ("ш", 0.718), ("щ", 0.361), ("ъ", 0.037), ("ы", 1.898), ("ь", 1.735), ("э", 0.331), ("ю", 0.638), ("я", 2.001)]
    
    private let lettersWithFrequenciesEng: [(char: Character, freq: Float)] = [("a", 8.4966), ("b", 2.0720), ("c", 4.5388), ("d", 3.3844), ("e", 11.1607), ("f", 1.8121), ("g", 2.4705), ("h", 3.0034), ("i", 7.5448), ("j", 0.1965), ("k", 1.1016), ("l", 5.4893), ("m", 3.0129), ("n", 6.6544), ("o", 7.1635), ("p", 3.1671), ("q", 0.1962), ("r", 7.5809), ("s", 5.7351), ("t", 6.9509), ("u", 3.6308), ("v", 1.0074), ("w", 1.2899), ("x", 0.2902), ("y", 1.7779), ("z", 0.2722)]

	private(set) var grid = [[Letter]]()
	private(set) var foundWords = Set<String>()
    private(set) var notExistingWords = Set<String>()
    private(set) var selectedLetters = [Letter]()
    private(set) var score = 0
    
    init() {
		grid = createGrid(withSize: 5)
	}

    mutating func newGame() {
        self = WordsGame()
    }
    
    mutating func endGame() {
        selectedLetters.removeAll()
        foundWords.removeAll()
        grid.removeAll()
    }
    
    mutating func selectLetter(row: Int, col: Int) {
        guard row <= grid.count, col <= grid[row].count else {
            return
        }

        if selectedLetters.isEmpty {
            selectAt(row: row, col: col)
        } else {
            guard let last = selectedLetters.last else {
                return
            }

            if last.row == row, last.col == col {
               return
            }

            // Remove last letter if returned to the previous
            if let prev = selectedLetters.dropLast().last {
                if prev.row == row, prev.col == col {
                    removeLetter()
                    return
                }
            }

            if selectedLetters.contains(where: { $0.row == row && $0.col == col }) {
                return
            }

            let distanceInGrid = Range(-1...1)
            if distanceInGrid.contains(last.row - row) && distanceInGrid.contains(last.col - col) {
                selectAt(row: row, col: col)
            }
       }
    }

    mutating func enterWord() -> String? {
        defer {
            deselectAll()
        }
        
		guard selectedLetters.count > 1 else {
			return nil
		}

        let word = selectedLetters.map { String($0.value) }.joined()
        
        if foundWords.contains(word) || notExistingWords.contains(word) {
            return nil
        }
        
        return word
    }
    
    mutating func addWord(_ word: String, isRealWord: Bool) {
        if isRealWord {
            foundWords.insert(word)
            score += word.count
        } else {
            notExistingWords.insert(word)
        }
    }

	private mutating func removeLetter() {
        if let last = selectedLetters.last {
            grid[last.row][last.col].isSelected = false
			selectedLetters.removeLast()
		}
	}
    
    private mutating func deselectAll() {
        selectedLetters.removeAll()
        
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                grid[row][col].isSelected = false
            }
        }
    }

	private func createGrid(withSize size: Int) -> [[Letter]] {
		var result = [[Letter]]()
        
        for row in 0..<size {
            var group = [Letter]()
            for col in 0..<size {
                let random = Float.random(in: 0...100)
                var rangeStart: Float = 0
                var rangeEnd: Float = 0
                
                for (letter, freq) in lettersWithFrequenciesEng {
                    rangeEnd += freq
                    if (rangeStart...rangeEnd).contains(random) {
                        group.append(Letter(letter, row: row, col: col))
                        break
                    }
                    
                    rangeStart += freq
                }
            }
            result.append(group)
        }

		return result
	}
    
    private mutating func selectAt(row: Int, col: Int) {
        selectedLetters.append(grid[row][col])
        grid[row][col].isSelected = true
    }

}
