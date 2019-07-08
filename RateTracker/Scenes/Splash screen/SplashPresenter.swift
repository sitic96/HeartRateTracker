//
//  SplashViewPresenter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase

protocol SplashPresenterProtocol {
    var router: SplashScreenRouterProtocol { get }
    func viewDidAppear()
}

class SplashPresenter {
    var router: SplashScreenRouterProtocol
    private let authUseCase: AuthenticationUseCaseProtocol

    init(router: SplashScreenRouterProtocol,
         authUseCase: AuthenticationUseCaseProtocol) {
        self.router = router
        self.authUseCase = authUseCase
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        if authUseCase.isUserSignedIn() {
            router.showMainController()
        } else {
            router.showLoginController()
        }
    }
}
