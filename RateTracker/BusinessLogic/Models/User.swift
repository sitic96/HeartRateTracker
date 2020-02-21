//
//  User.swift
//  RateTracker
//
//  Created by Sitora on 06/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
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
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as! String
        self.name = coder.decodeObject(forKey: "name") as! String
        self.email = coder.decodeObject(forKey: "email") as! String
        self.birthDate = coder.decodeObject(forKey: "birthDate") as? Date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(birthDate, forKey: "birthDate")
    }
}
