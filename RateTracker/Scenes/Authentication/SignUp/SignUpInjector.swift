//
//  SignUpInjector.swift
//  RateTracker
//
//  Created by Sitora on 01/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct SignUpInjector {
    private init() { }

    static func inject<View: UIViewController & SignUpViewProtocol>(_ view: View) {
        let signUpRouter = SignUpRouter()
        let authGateway = AuthenticationGateway()
        let authUseCase = AuthenticationUseCase(authenticationGateway: authGateway)
        let signUpPresenter = SignUpPresenter(view,
                                              router: signUpRouter,
                                              authUseCase: authUseCase)
        view.presenter = signUpPresenter
    }
}
