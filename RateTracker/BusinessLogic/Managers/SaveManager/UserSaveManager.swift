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
    func edit(with newUserData: User)
    func delete()
}

class UserSaveManager {
    private let key = "userInfo"
    
    init() { }
}

extension UserSaveManager: UserSaveManagerProtocol {
    func user() -> User? {
        let decoded = UserDefaults.standard.object(forKey: key) as! Data
        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? User
    }
    
    func edit(with newUserData: User) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: newUserData)
        UserDefaults.standard.set(encodedData, forKey: key)
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
