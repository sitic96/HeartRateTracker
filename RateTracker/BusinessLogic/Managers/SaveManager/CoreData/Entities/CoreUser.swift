//
//  CoreUser.swift
//  RateTracker
//
//  Created by Sitora on 07/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
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
                                                        throw CoreDataError.undefined(message: CoreUser.entityName)
        }
        self.init(entity: entity, insertInto: context)
        self.fbUid = user.id
        self.name = user.name
        self.email = user.email
        self.birthDate = user.birthDate
    }
}

extension CoreUser {
    func toUser() -> User {
        return User(id: self.fbUid!, name: self.name!,
                    email: self.email!, birthDate: self.birthDate)
    }
}
