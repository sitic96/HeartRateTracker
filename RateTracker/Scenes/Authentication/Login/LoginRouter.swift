//
//  LoginRouter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol LoginRouterProtocol {
    func showMainVC()
    func showSignUpVC()
}

struct LoginRouter {
    weak var viewController: (UIViewController & LoginViewProtocol)?
}

extension LoginRouter: LoginRouterProtocol {
    func showMainVC() {

    }

    func showSignUpVC() {

    }
}
