//
//  CoreDataManager.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var container: NSPersistentContainer { get }
    
    func deleteAllObjects(in context: NSManagedObjectContext) throws
    func fetchData<T: NSFetchRequestResult>(_ entityName: String,
                                            predicate: NSPredicate?) throws -> [T]
    func saveContext() throws
}

class CoreDataManager: CoreDataManagerProtocol {
    static let shared: CoreDataManager = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    var container: NSPersistentContainer {
        return persistentContainer
    }
    
    // MARK: - Lifecycle
    
    private init!() {
        let container = NSPersistentContainer(name: "HeartTracker")
        
        var initializationError: Error?
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            initializationError = error
        })
        if initializationError != nil {
            return nil
        }
        persistentContainer = container
    }
    
    // MARK: - Public
    
    func fetchData<T: NSFetchRequestResult>(_ entityName: String,
                                            predicate: NSPredicate? = nil) throws -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        var result: [T] = []
        var fetchingError: Error?
        persistentContainer.viewContext.performAndWait {
            do {
                result = try persistentContainer.viewContext.fetch(fetchRequest)
            } catch let error {
                fetchingError = error
            }
        }
        if let error = fetchingError {
            throw error
        }
        return result
    }
    
    func deleteAllObjects(in context: NSManagedObjectContext) throws {
        persistentContainer.managedObjectModel.entities.forEach {
            guard let entityName = $0.name else {
                return
            }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    guard let object = (object as? NSManagedObject) else {
                        continue
                    }
                    context.performAndWait {
                        context.delete(object)
                    }
                    
                    do {
                        try context.save()
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
    }
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
            try context.parent?.save()
        }
    }
}
