//
//  AuthViewModel.swift
//  RateTracker
//
//  Created by Sitora on 01/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol AuthViewModelProtocol {
    func viewDidSelectLogin(email: String?, password: String?)
    func viewDidSelectSignUp(name: String?, email: String?, password: String?)
    func viewDidSelectSkip()
}

class AuthViewModel {
    private weak var coordinator: AuthCoordinatorProtocol?

    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

extension AuthViewModel: AuthViewModelProtocol {
    func viewDidSelectLogin(email: String?, password: String?) {

    }

    func viewDidSelectSignUp(name: String?, email: String?, password: String?) {
        
    }

    func viewDidSelectSkip() {
        coordinator?.showMainController()
    }
}
