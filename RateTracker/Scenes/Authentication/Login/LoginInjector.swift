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
        let loginPresenter = LoginPresenter(router: loginRouter)
        view.presenter = loginPresenter
    }
}
