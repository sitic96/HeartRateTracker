//
//  AuthenticationGateway.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase
import CoreData

typealias UserCompletionHandler = (_ result: Result<User, Error>) -> Void
protocol AuthenticationGatewayProtocol {
    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler)
    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler)
    func userDidRejectSignUp()
    func isUserSignedIn() -> Bool
}

class AuthenticationGateway {
    private let session: SessionManagerProtocol
    private let coreData: CoreDataManagerProtocol

    init(session: SessionManagerProtocol,
         coreData: CoreDataManagerProtocol) {
        self.session = session
        self.coreData = coreData
    }

    private func userDidLaunchAppFirstTime(user: User) {
        session.currentUser = user
        session.isUserFirstLaunch = true
    }

    private func save(user: User) throws {
        let context = coreData.container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        try coreData.deleteAllObjects(in: context)
        _ = try CoreUser(from: user, in: context)
        try context.save()

    }
}

extension AuthenticationGateway: AuthenticationGatewayProtocol {
    func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }

    func login(with login: String,
               password: String,
               completion: @escaping UserCompletionHandler) {
        Auth.auth().signIn(withEmail: login,
                           password: password) { [weak self] authResult, error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                if let user = authResult?.user {
                                    var appUser = User()
                                    appUser.email = user.email
                                    do {
                                        try self?.save(user: appUser)
                                    } catch let error {
                                        completion(.failure(error))
                                    }
                                    self?.session.currentUser = appUser
                                    completion(.success(appUser))
                                }
                            }
        }
    }

    func signup(with login: String,
                password: String,
                completion: @escaping UserCompletionHandler) {
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let user = authResult?.user {
                    var appUser = User()
                    appUser.email = user.email
                    self?.userDidLaunchAppFirstTime(user: appUser)
                    do {
                        try self?.save(user: appUser)
                    } catch let error {
                        completion(.failure(error))
                    }
                    completion(.success(appUser))
                }
            }
        }
    }

    func userDidRejectSignUp() {
        // TODO: replace in future for non register user
        userDidLaunchAppFirstTime(user: User())
    }
}
