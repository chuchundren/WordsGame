//
//  GameOverViewModel.swift
//  Words
//
//  Created by Dasha Palshau on 31.10.2022.
//

import Foundation

final class GameOverViewModel: ObservableObject {
    
    @Published private(set) var statsDict = [String: StatisticsModel]()
    
    let newScore: Int
    let foundWords: [String]
    
    private let store: StatisticsStoreProtocol
    
    init(newScore: Int, foundWords: [String], store: StatisticsStoreProtocol = StatisticsCoreDataStore.shared) {
        self.newScore = newScore
        self.foundWords = foundWords
        self.store = store
        
        saveNewStatistics()
    }
    
    func saveNewStatistics() {
        let maxWordLength = foundWords.sorted { $0.count > $1.count }.first?.count ?? 0
        
        do {
            if statsDict[StatName.bestScore.rawValue]?.value ?? 0 < newScore {
                try store.save(StatName.bestScore.rawValue, value: newScore)
            }
            
            if statsDict[StatName.mostWords.rawValue]?.value ?? 0 < foundWords.count {
                try store.save(StatName.mostWords.rawValue, value: foundWords.count)
            }
            
            if statsDict[StatName.maxWordLenght.rawValue]?.value ?? 0 < maxWordLength {
                try store.save(StatName.maxWordLenght.rawValue, value: maxWordLength)
            }
            
            try store.save(StatName.totalGames.rawValue, value: Int(statsDict[StatName.totalGames.rawValue]?.value ?? 0) + 1)
        } catch {
            print(error)
        }
    }
    
    func fetchStatistics() {
        do {
            try store.fetchStatistics().forEach { stat in
                statsDict[stat.name ?? ""] = stat
                print(statsDict)
            }
        } catch {
            print(error)
        }
    }
    
    enum StatName: String {
        case bestScore = "Best score"
        case mostWords = "Most words found"
        case maxWordLenght = "Maximum found word length"
        case totalGames = "Total games played"
    }
    
}
