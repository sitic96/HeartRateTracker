//
//  UserSaveManager.swift
//  RateTracker
//
//  Created by Sitora on 07/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

protocol UserSaveManagerProtocol {
    func user() -> User?
    func edit(with newUserData: User, completion: @escaping SaveManagerCompletion)
    func delete(completion: @escaping SaveManagerCompletion)
}

class UserSaveManager {
    private let coreData: CoreDataManagerProtocol
    
    init(coreData: CoreDataManagerProtocol) {
        self.coreData = coreData
    }
}

extension UserSaveManager: UserSaveManagerProtocol {
    func user() -> User? {
        do {
            let coreUser: [CoreUser] =
                try coreData.fetchData(CoreUser.entityName, predicate: nil)
            return coreUser.first?.toUser()
        } catch _ {
            return nil
        }
    }
    
    func edit(with newUserData: User, completion: @escaping SaveManagerCompletion) {
        let context = coreData.container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        do {
            try CoreUser(from: newUserData, in: context)
            try context.save()
            completion(.success(Void()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func delete(completion: @escaping SaveManagerCompletion) {
        let context = coreData.container.newBackgroundContext()
        do {
            try coreData.deleteAllObjects(in: context)
            completion(.success(Void()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
