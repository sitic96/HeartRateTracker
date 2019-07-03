//
//  SignUpOfferPresenter.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol SignUpOfferPresenterProtocol {
    var router: SignUpOfferRouterProtocol { get }

    func userDidRejectSignUp()
}

class SignUpOfferPresenter {
    var router: SignUpOfferRouterProtocol
    private let authUseCase: AuthenticationUseCaseProtocol

    init(router: SignUpOfferRouterProtocol,
         authUseCase: AuthenticationUseCaseProtocol) {
        self.router = router
        self.authUseCase = authUseCase
    }
}

extension SignUpOfferPresenter: SignUpOfferPresenterProtocol {
    func userDidRejectSignUp() {
        authUseCase.userDidRejectSignUp()
    }
}
