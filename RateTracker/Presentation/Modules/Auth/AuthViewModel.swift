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
    
    var isLoading = BehaviorRelay(value: false)
    var errorMessage = BehaviorRelay(value: "")
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
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
                strongSelf.coordinator?.showMainController()
            }
        }
    }
    
    func viewDidSelectSignUp(name: String?, email: String?, password: String?) {
        guard let email = email,
            !email.isEmpty,
            let password = password,
            !password.isEmpty else {
                coordinator?.showError(errorMessage: "Email or password is empty")
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
                strongSelf.coordinator?.showMainController()
            }
        }
    }
    
    func viewDidSelectSkip() {
        coordinator?.showMainController()
    }
}