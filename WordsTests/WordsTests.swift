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
        sut.enterWord()
        
        XCTAssertEqual(sut.foundWords.count, 0)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testWordEnterFails_whenWordAlreadyFound() {
        var sut = WordsGame()
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        sut.enterWord()
        
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        sut.enterWord()
        
        XCTAssertEqual(sut.foundWords.count, 1)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
    
    func testWordEnterSuccesses() {
        var sut = WordsGame()
        sut.selectLetter(row: 0, col: 0)
        sut.selectLetter(row: 1, col: 0)
        sut.selectLetter(row: 2, col: 1)
        sut.enterWord()
        
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
        sut.enterWord()
        
        sut.newGame()
        XCTAssertEqual(sut.foundWords.count, 0)
        XCTAssertEqual(sut.selectedLetters.count, 0)
    }
}
