//
//  LoginInjector.swift
//  RateTracker
//
//  Created by Sitora on 28/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct LoginInjector {
    private init() { }

    static func inject<View: UIViewController & LoginViewProtocol>(_ view: View) {
        let loginRouter = LoginRouter(viewController: view)
        let authGateway = AuthenticationGateway()
        let authUseCase = AuthenticationUseCase(authenticationGateway: authGateway)
        let loginPresenter = LoginPresenter(view,
                                            router: loginRouter,
                                            authUseCase: authUseCase)
        view.presenter = loginPresenter
    }
}
