//
//  AuthenticationGateway.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase

typealias UserCompletionHandler = (_ result: Result<User, Error>) -> Void
protocol AuthenticationGatewayProtocol {
    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler)
    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler)
}

class AuthenticationGateway {

}

extension AuthenticationGateway: AuthenticationGatewayProtocol {
    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler) {
        Auth.auth().signIn(withEmail: login,
                           password: password) { authResult, error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                if let user = authResult?.user {
                                    let appUser = User(email: user.email)
                                    completion(.success(appUser))
                                }
                            }
        }
    }

    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let user = authResult?.user {
                    let appUser = User(email: user.email)
                    completion(.success(appUser))
                }
            }
        }
    }
}
