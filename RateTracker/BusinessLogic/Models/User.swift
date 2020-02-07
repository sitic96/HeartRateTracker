//
//  User.swift
//  RateTracker
//
//  Created by Sitora on 06/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let name: String
    let email: String
    let birthDate: Date?

    init(id: String,
         name: String,
         email: String,
         birthDate: Date?) {
        self.id = id
        self.name = name
        self.email = email
        self.birthDate = birthDate
    }
}
