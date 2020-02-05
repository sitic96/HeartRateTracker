//
//  HeartDataSaveManager.swift
//  RateTracker
//
//  Created by Sitora on 04/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

protocol HeartScanSaveManagerProtocol {
    func allRecords() -> [HeartScan]
    func records(since: Date) -> [HeartScan]
    func records(till: Date) -> [HeartScan]
    func records(since: Date, till: Date) -> [HeartScan]
    
    func save(_ record: HeartScan, completion: @escaping SaveManagerCompletion)
}

class HeartScanSaveManager: SaveManager {
    private let coreData: CoreDataManagerProtocol
    
    init(coreData: CoreDataManagerProtocol) {
        self.coreData = coreData
    }
    
    private func fetch(predicate: NSPredicate? = nil) -> [HeartScan] {
        do {
            let coreRecords: [CoreHeartScan] =
                try coreData.fetchData(CoreHeartScan.entityName, predicate: predicate)
            return coreRecords.map { $0.toHeartScan() }
        } catch _ {
            return []
        }
    }
}

extension HeartScanSaveManager: HeartScanSaveManagerProtocol {
    func allRecords() -> [HeartScan] {
        return fetch()
    }
    
    func records(since: Date) -> [HeartScan] {
        let predicate = NSPredicate(format: "(startedAt >= %@)",
                                    startOfTheDay(for: since))
        return fetch(predicate: predicate)
    }
    
    func records(till: Date) -> [HeartScan] {
        let predicate = NSPredicate(format: "(finishedAt <= %@)",
                                    endOfTheDay(for: till))
        return fetch(predicate: predicate)
    }
    
    func records(since: Date, till: Date) -> [HeartScan] {
        let predicate = NSPredicate(format: "(startedAt >= %@) AND (finishedAt <= %@)",
                                    startOfTheDay(for: since),
                                    endOfTheDay(for: till))
        return fetch(predicate: predicate)
    }
    
    func save(_ record: HeartScan, completion: @escaping SaveManagerCompletion) {
        let context = coreData.container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        do {
            try CoreHeartScan(from: record, in: context)
            try context.save()
            completion(.success(Void()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
