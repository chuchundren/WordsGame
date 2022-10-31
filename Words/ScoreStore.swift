//
//  ScoreStore.swift
//  Words
//
//  Created by Dasha Palshau on 31.10.2022.
//

import Foundation
import CoreData

protocol ScoreStoreProtocol {
    func save(_ newScore: Int) throws
    func fetch() throws -> [Score]
    func deleteAll() throws
}

final class ScoreCoreDataStore: ScoreStoreProtocol {
    
    static let shared = ScoreCoreDataStore()
    
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
        ScoreCoreDataStore.persistentContainer.viewContext
    }()
    
    private init() {}
    
    func save(_ newScore: Int) throws {
        let score = Score(context: mainContext)
        score.date = Date()
        score.value = Int16(newScore)
        
        try save()
    }
    
    func fetch() throws -> [Score] {
        let fetchRequest = Score.fetchRequest()
        let sort = NSSortDescriptor(key: "value", ascending: false)
        
        fetchRequest.sortDescriptors = [sort]
        
        let scores = try mainContext.fetch(fetchRequest)
        return scores
    }
    
    func deleteAll() throws {
        let fetchRequest = Score.fetchRequest()
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
