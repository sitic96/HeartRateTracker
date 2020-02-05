//
//  CoreDataError.swift
//  RateTracker
//
//  Created by Sitora on 04/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

enum CoreDataError: Error {
    case undefined(message: String?)
}

// MARK: - CustomStringConvertible

extension CoreDataError: CustomStringConvertible {
    var description: String {
        switch self {
        case .undefined(let message):
            return message ?? "Unknown CoreData error happened"
        }
    }
}
