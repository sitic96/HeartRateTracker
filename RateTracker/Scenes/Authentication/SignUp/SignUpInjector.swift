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
        let signUpRouter = SignUpRouter(viewController: view)
        let authGateway = AuthenticationGateway(session: SessionManager.shared,
                                                coreData: CoreDataManager.shared)
        let authUseCase = AuthenticationUseCase(authenticationGateway: authGateway)
        let signUpPresenter = SignUpPresenter(view,
                                              router: signUpRouter,
                                              authUseCase: authUseCase)
        view.presenter = signUpPresenter
    }
}
