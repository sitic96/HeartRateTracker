//
//  ConfigurationManager.swift
//  RateTracker
//
//  Created by Sitora Guliamova on 4/5/20.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol ConfigurationManagerProtocol {
    var isAnonMode: Bool { get set }
}

class ConfigurationManager {
    static let shared = ConfigurationManager()
    private let userDefaults: UserDefaults

    private init() {
        self.userDefaults = UserDefaults.standard
    }
}

extension ConfigurationManager: ConfigurationManagerProtocol {
    var isAnonMode: Bool {
        get {
            return userDefaults.bool(forKey: Const.isAnonModeKey)
        }
        set {
            userDefaults.set(newValue, forKey: Const.isAnonModeKey)
        }
    }
}

fileprivate extension Const {
    static let isAnonModeKey = "isAnonMode"
}
