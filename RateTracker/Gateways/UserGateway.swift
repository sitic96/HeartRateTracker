//
//  UserGateway.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol UserGatewayProtocol {
    var isUserFirstAppLaunch: Bool { get }
    var currentUser: User { get }
}

class UserGateway {
    private var session: SessionManagerProtocol

    init(session: SessionManagerProtocol) {
        self.session = session
    }
}

extension UserGateway: UserGatewayProtocol {
    var isUserFirstAppLaunch: Bool {
        get {
            return session.isUserFirstLaunch
        }
    }

    var currentUser: User {
        get {
            return session.currentUser
        }
    }
}
