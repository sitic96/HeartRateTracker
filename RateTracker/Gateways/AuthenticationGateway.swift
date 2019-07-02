//
//  AuthenticationGateway.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol AuthenticationGatewayProtocol {
    func login(with login: String,
               password: String)
    func signup(with login: String,
                password: String)
}

class AuthenticationGateway {

}

extension AuthenticationGateway: AuthenticationGatewayProtocol {
    func login(with login: String, password: String) {

    }

    func signup(with login: String, password: String) {

    }
}
