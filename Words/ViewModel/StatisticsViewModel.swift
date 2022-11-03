//
//  StatisticsViewModel.swift
//  Words
//
//  Created by Dasha Palshau on 04.11.2022.
//

import Foundation

final class StatisticsViewModel: ObservableObject {
    @Published private(set) var statsDict = [String: StatisticsModel]()
    
    private let store: StatisticsStoreProtocol
    
    init(store: StatisticsStoreProtocol = StatisticsCoreDataStore.shared) {
        self.store = store
    }
    
    func fetchStatistics() {
        do {
            try store.fetchStatistics().forEach { stat in
                statsDict[stat.name ?? ""] = stat
            }
        } catch {
            print(error)
        }
    }
    
}
