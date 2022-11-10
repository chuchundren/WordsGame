//
//  WordsTests.swift
//  WordsTests
//
//  Created by Dasha Palshau on 03.09.2022.
//

import XCTest
@testable import Words

class WordsTests: XCTestCase {
    
    func testGridCreation() {
        let sut = WordsGame()
        
        XCTAssertEqual(sut.grid.count, 5)
        XCTAssertEqual(sut.grid[0].count, 5)
        
        for row in 0..<sut.grid.count {
            for col in 0..<sut.grid[row].count {
                XCTAssertEqual(sut.grid[row][col].row, row)
                XCTAssertEqual(sut.grid[row][col].col, col)
            }
        }
    }
    
    func testSelectionAndDeselectionOfLetters() {
        var sut = WordsGame()
        sut.selectLetter(row: 1, col: 2)
        XCTAssertEqual(sut.selectedLetters.count, 1)
        
        sut.selectLetter(row: 4, col: 5)
        XCTAssertEqual(sut.selectedLetters.count, 1)
        
        sut.selectLetter(row: 2, col: 2)
        XCTAssertEqual(sut.selectedLetters.count, 2)

        sut.selectLetter(row: 1, col: 2)
        XCTAssertEqual(sut.selectedLetters.count, 1)
    }
    
    func testWordEnterFails_whenSelectedLettersLessThanTwo() {
        var sut = WordsGame()
        sut.selectLetter(row: 0, col: 0)
        _ = sut.enterWord()
        
        XCTAssertEqual(sut.foundWords.count, 0)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testWordEnterSuccesses() throws {
        var sut = WordsGame()
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        
        let enter = sut.enterWord()
        let word = try XCTUnwrap(enter.0)
        let score = try XCTUnwrap(enter.1)
        sut.addWord(word, isRealWord: true, score: score)
        
        XCTAssertEqual(sut.foundWords.count, 1)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testWordEnterFails_whenWordAlreadyFound() throws {
        var sut = WordsGame()
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        
        let enter = sut.enterWord()
        let word = try XCTUnwrap(enter.0)
        let score = try XCTUnwrap(enter.1)
        sut.addWord(word, isRealWord: true, score: score)
        
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        
        let enterTry = sut.enterWord()
        XCTAssertNil(enterTry.0)
        XCTAssertNil(enterTry.1)
        XCTAssertEqual(sut.foundWords.count, 1)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testNewGameStart() {
        var sut = WordsGame()
        XCTAssertEqual(sut.foundWords.count, 0)
        XCTAssertEqual(sut.selectedLetters.count, 0)
        
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        _ = sut.enterWord()
        
        sut.newGame()
        XCTAssertEqual(sut.foundWords.count, 0)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testBonusesWereAssignedToLetters() {
        let sut = WordsGame()
        
        var bonuses = [Bonus]()
        
        for row in sut.grid {
            for letter in row {
                if case let bonus = letter.bonus, let bonusUnwraped = bonus {
                    bonuses.append(bonusUnwraped)
                }
            }
        }
        
        XCTAssertEqual(bonuses.count, 4)
        XCTAssert(bonuses.contains(.multiplyBy(value: .two)))
        XCTAssert(bonuses.contains(.multiplyBy(value: .three)))
        XCTAssert(bonuses.contains(.add(value: .two)))
        XCTAssert(bonuses.contains(.add(value: .three)))
    }
    
}
