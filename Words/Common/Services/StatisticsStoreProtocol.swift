//
//  StatisticsStoreProtocol.swift
//  Words
//
//  Created by Dasha Palshau on 01.11.2022.
//

import Foundation
import CoreData


protocol StatisticsStoreProtocol {
    func save(_ statisticName: String, value: Int) throws
    func fetchStatistics() throws -> [StatisticsModel]
    func deleteAll() throws
}

final class StatisticsCoreDataStore: StatisticsStoreProtocol {
    
    static let shared = StatisticsCoreDataStore()
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WordsModel")

        container.loadPersistentStores { _, error in
            if let error = error {
                //TODO: - Add Error Handling
                fatalError("Unresolved error: \(error)")
            }
        }
        
        return container
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        StatisticsCoreDataStore.persistentContainer.viewContext
    }()
    
    private init() {}
    
    func save(_ name: String, value: Int) throws {
        let fetchRequest = StatisticsModel.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        
        fetchRequest.predicate = predicate
        
        if let statistic = try mainContext.fetch(fetchRequest).first {
            statistic.value = Int16(value)
            statistic.date = Date()
        } else {
            let statistic = StatisticsModel(context: mainContext)
            statistic.name = name
            statistic.value = Int16(value)
            statistic.date = Date()
        }
        
        try save()
    }
    
    func fetchStatistics() throws -> [StatisticsModel] {
        let fetchRequest = StatisticsModel.fetchRequest()
        
        let statistics = try mainContext.fetch(fetchRequest)
        return statistics
    }
        
    func deleteAll() throws {
        let fetchRequest = StatisticsModel.fetchRequest()
        let data = try mainContext.fetch(fetchRequest)
        data.forEach { mainContext.delete($0) }
        
        try save()
    }
    
    // MARK: Private methods
    
    private func save() throws {
        if mainContext.hasChanges {
            try mainContext.save()
        }
    }
    
}
