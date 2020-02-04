//
//  HeartDataSaveManager.swift
//  RateTracker
//
//  Created by Sitora on 04/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

protocol HeartDataSaveManagerProtocol {
    func allRecords() -> [HeartData]
    func records(since: Date) -> [HeartData]
    func records(till: Date) -> [HeartData]
    func records(since: Date, till: Date) -> [HeartData]

    func save(_ record: HeartData, completion: @escaping SaveManagerCompletion)
}

class HeartDataSaveManager: SaveManager {
    private let coreData: CoreDataManagerProtocol

    init(coreData: CoreDataManagerProtocol) {
        self.coreData = coreData
    }

    private func fetch(predicate: NSPredicate? = nil) -> [HeartData] {
        do {
            let coreRecords: [CoreHeartData] =
                try coreData.fetchData(CoreHeartData.entityName, predicate: predicate)
            return coreRecords.map { $0.toHeartData() }
        } catch _ {
            return []
        }
    }
}

extension HeartDataSaveManager: HeartDataSaveManagerProtocol {
    func allRecords() -> [HeartData] {
        return fetch()
    }

    func records(since: Date) -> [HeartData] {
         let predicate = NSPredicate(format: "(timeStamp >= %@)",
                                     startOfTheDay(for: since))
        return fetch(predicate: predicate)
    }

    func records(till: Date) -> [HeartData] {
        let predicate = NSPredicate(format: "(timeStamp <= %@)",
                                     endOfTheDay(for: till))
        return fetch(predicate: predicate)
    }

    func records(since: Date, till: Date) -> [HeartData] {
        let predicate = NSPredicate(format: "(activityDate >= %@) AND (activityDate <= %@)",
                                     startOfTheDay(for: since),
                                     endOfTheDay(for: till))
        return fetch(predicate: predicate)
    }

    func save(_ record: HeartData, completion: @escaping SaveManagerCompletion) {
        let context = coreData.container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        do {
            try CoreHeartData(from: record, in: context)
            try context.save()
            completion(.success(Void()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
