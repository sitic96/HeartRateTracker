//
//  SessionManager.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol SessionManagerProtocol: AnyObject {
    var isUserFirstLaunch: Bool { get set }

    func resetSession()
}

class SessionManager {
    static let shared = SessionManager()

    var isUserFirstLaunch: Bool = false

    private init() {
    }
}

extension SessionManager: SessionManagerProtocol {
    func resetSession() {

    }
}
