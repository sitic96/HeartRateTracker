//
//  LocalizableKeys.swift
//  RateTracker
//
//  Created by Sitora on 28/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

enum LocalizableKeys {
    // MARK: - Global

    static let ok = "OK"
    
    // MARK: - Login

    static let wrongEmail = "Incorrect email"
    static let emptyLoginFields = "Email or password is empty"
    static let shortPassword = "Password is too short"
    static let loginError = "Login failed, check your data and try again"

    // MARK: - Sign Up

    static let passwordNotMatch = "Passwords not match"

    // MARK: - Error handling

    static let error = "Error"

    // MARK: - BLE

    enum BLE {
        static let chest = "Chest"
        static let wrist = "Wrist"
        static let finger = "Finger"
        static let hand = "Hand"
        static let earLobe = "Ear lobe"
        static let foot = "Foot"
        static let unknown = "Unknown"
    }

}
