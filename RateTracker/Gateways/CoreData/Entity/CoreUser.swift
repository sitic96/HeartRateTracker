//
//  CoreUser.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

@objc(CoreUser)
public class CoreUser: NSManagedObject {
    class var entityName: String {
        return "CoreUser"
    }

    convenience init(from user: User, in context: NSManagedObjectContext) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: CoreUser.entityName,
                                                      in: context) else {
                                                        throw UserError.invalidDatabaseState
        }
        self.init(entity: entity, insertInto: context)
        self.email = user.email
    }
}

extension CoreUser {
    func toUser() -> User {
        return User(email: self.email)
    }
}
