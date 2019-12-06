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
}

class CoreDataManager: CoreDataManagerProtocol {
    static let shared: CoreDataManager = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var container: NSPersistentContainer {
        return persistentContainer
    }

    // MARK: - Lifecycle

    private init!() {
        let container = NSPersistentContainer(name: "RateTracker")
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true

        container.persistentStoreDescriptions = [description]

        var initializationError: Error?

        container.loadPersistentStores(completionHandler: { (_, error) in
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            initializationError = error
        })
        if initializationError != nil {
            return nil
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
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

    func insert<T: NSManagedObject>(_ objects: T...) throws {
        try insert(objects)
    }

    func insert<T: NSManagedObject>(_ objects: [T]) throws {
        for object in objects {
            persistentContainer.viewContext.insert(object)
        }
        try saveContext()
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
                }
            }
        }

    }

    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
}
