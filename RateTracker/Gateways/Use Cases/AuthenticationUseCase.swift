//
//  AuthenticationUseCase.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol AuthenticationUseCaseProtocol {
    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler)
    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler)
    func isUserSignedIn() -> Bool
    func userDidRejectSignUp()
}

class AuthenticationUseCase {
    let authenticationGateway: AuthenticationGatewayProtocol

    init(authenticationGateway: AuthenticationGatewayProtocol) {
        self.authenticationGateway = authenticationGateway
    }
}

extension AuthenticationUseCase: AuthenticationUseCaseProtocol {
    func isUserSignedIn() -> Bool {
        return authenticationGateway.isUserSignedIn()
    }

    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler) {
        authenticationGateway.login(with: login, password: password, completion: completion)
    }

    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler) {
        authenticationGateway.signup(with: login, password: password, completion: completion)
    }

    func userDidRejectSignUp() {
        authenticationGateway.userDidRejectSignUp()
    }
}
