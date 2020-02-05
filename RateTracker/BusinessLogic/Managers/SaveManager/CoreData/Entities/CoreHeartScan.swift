//
//  CoreHeartScan.swift
//  RateTracker
//
//  Created by Sitora on 05/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import CoreData

@objc(CoreHeartScan)
public class CoreHeartScan: NSManagedObject {
    class var entityName: String {
        return "CoreHeartScan"
    }
    
    convenience init(from scan: HeartScan, in context: NSManagedObjectContext) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: CoreHeartScan.entityName,
                                                      in: context) else {
                                                        throw CoreDataError.undefined(message: CoreHeartScan.entityName)
        }
        self.init(entity: entity, insertInto: context)
        self.startedAt = scan.startedAt
        self.sensorPosition = scan.sensorPosition.rawValue
        self.finishedAt = scan.finishedAt
        self.name = scan.name
        self.notes = scan.notes
        self.heartData = try NSSet(array: scan.data.map { try CoreHeartData(from: $0, in: context) })
    }
}

extension CoreHeartScan {
    func toHeartScan() -> HeartScan {
        return HeartScan(startedAt: self.startedAt!,
                         finishedAt: self.finishedAt!,
                         sensorPosition: SensorPosition(from: self.sensorPosition!),
                         data: self.heartData!
                            .map { ($0 as! CoreHeartData).toHeartData() },
                         notes: self.notes,
                         name: self.name)
    }
}
