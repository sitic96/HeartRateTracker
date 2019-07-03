//
//  UserGateway.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol UserGatewayProtocol {
    func isUserFirstAppLaunch() -> Bool
}

class UserGateway {
    private var session: SessionManagerProtocol

    init(session: SessionManagerProtocol) {
        self.session = session
    }
}

extension UserGateway: UserGatewayProtocol {
    func isUserFirstAppLaunch() -> Bool {
        return session.isUserFirstLaunch
    }
}
