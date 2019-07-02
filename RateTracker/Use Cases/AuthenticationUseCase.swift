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
               password: String)
    func signup(with login: String,
                password: String)
}

class AuthenticationUseCase {

}

extension AuthenticationUseCase: AuthenticationUseCaseProtocol {
    func login(with login: String, password: String) {

    }

    func signup(with login: String, password: String) {

    }
}
