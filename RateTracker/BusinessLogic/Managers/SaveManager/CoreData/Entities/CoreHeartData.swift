//
//  CoreHeartData.swift
//  RateTracker
//
//  Created by Sitora on 04/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

@objc(CoreHeartData)
public class CoreHeartData: NSManagedObject {
    class var entityName: String {
        return "CoreHeartData"
    }

    convenience init(from heartData: HeartData, in context: NSManagedObjectContext) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: CoreHeartData.entityName,
                                                      in: context) else {
                                                        throw CoreDataError.undefined(message: CoreHeartData.entityName)
        }
        self.init(entity: entity, insertInto: context)
        self.bpm = Int16(heartData.bpm)
        self.rrValues = heartData.rrValues
        self.timeStamp = heartData.date
    }
}

extension CoreHeartData {
    func toHeartData() -> HeartData {
        return HeartData(bpm: Int(self.bpm),
                         rrValues: self.rrValues!,
                         date: self.timeStamp!)
    }
}
