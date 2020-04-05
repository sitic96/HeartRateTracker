//
//  AuthViewModel.swift
//  RateTracker
//
//  Created by Sitora on 01/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

protocol AuthViewModelProtocol {
    var isLoading: BehaviorRelay<Bool> { get }
    
    func viewDidSelectLogin(email: String?, password: String?)
    func viewDidSelectSignUp(name: String?, email: String?, password: String?)
    func viewDidSelectSkip()
}

class AuthViewModel {
    private weak var coordinator: AuthCoordinatorProtocol?

    private let userSaveManager: UserSaveManagerProtocol
    private var ref: DatabaseReference!
    var isLoading = BehaviorRelay(value: false)
    
    init(coordinator: AuthCoordinatorProtocol,
         userSaveManager: UserSaveManagerProtocol) {
        self.coordinator = coordinator
        self.userSaveManager = userSaveManager
        ref = Database.database().reference()
    }
}

extension AuthViewModel: AuthViewModelProtocol {
    func viewDidSelectLogin(email: String?, password: String?) {
        guard let email = email,
            !email.isEmpty,
            let password = password,
            !password.isEmpty else {
                coordinator?.showError(errorMessage: "Email or password is empty")
                return
        }
        isLoading.accept(true)
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading.accept(false)
            if let error = error {
                strongSelf.coordinator?.showError(errorMessage: error.localizedDescription)
            } else {
                let userID = Auth.auth().currentUser!.uid
                strongSelf.ref.child(FirebaseKeys.Users.usersTableName)
                    .child(userID).observeSingleEvent(of: .value, with: { snapshot in
                        let data = (snapshot.value as? NSDictionary)
                        let name = data?[FirebaseKeys.Users.name] as? String ?? ""
                        let birthDate = data?[FirebaseKeys.Users.birthDate] as? Date

                        strongSelf.userSaveManager.edit(with: User(id: userID, name: name,
                                                                   email: email, birthDate: birthDate))
                    }) { error in
                    print(error.localizedDescription)
                }
                
                strongSelf.coordinator?.showMainController()
            }
        }
    }
    
    func viewDidSelectSignUp(name: String?, email: String?, password: String?) {
        guard let email = email,
            !email.isEmpty,
            let password = password,
            !password.isEmpty,
            let name = name,
            !name.isEmpty else {
                coordinator?.showError(errorMessage: LocalizableKeys.emptyLoginFields.localized)
                return
        }
        isLoading.accept(true)
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading.accept(false)
            if let error = error {
                strongSelf.coordinator?.showError(errorMessage: error.localizedDescription)
            } else {
                let userID = Auth.auth().currentUser!.uid
                strongSelf.ref.child(FirebaseKeys.Users.usersTableName)
                    .child(userID).setValue([FirebaseKeys.Users.name: name,
                                             FirebaseKeys.Users.email: email])
                strongSelf.userSaveManager.edit(with: User(id: userID, name: name,
                                                           email: email, birthDate: nil))
                strongSelf.coordinator?.showMainController()
            }
        }
    }
    
    func viewDidSelectSkip() {
        userSaveManager.edit(with: User.anonUser())
        ConfigurationManager.shared.isAnonMode = true
        coordinator?.showMainController()
    }
}

fileprivate extension User {
    static func anonUser() -> User {
        return User.init(id: "", name: "Anon", email: "", birthDate: nil)
    }
}
