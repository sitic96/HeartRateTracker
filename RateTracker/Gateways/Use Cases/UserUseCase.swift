//
//  UserUseCase.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol UserUseCaseProtocol {
    var isUserFirstLaunchApp: Bool { get }
}

class UserUseCase {
    private let userGateway: UserGatewayProtocol

    init(userGateway: UserGatewayProtocol) {
        self.userGateway = userGateway
    }
}

extension UserUseCase: UserUseCaseProtocol {
    var isUserFirstLaunchApp: Bool {
        get {
            return userGateway.isUserFirstAppLaunch()
        }
    }
}
