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
    func prepare(for segue: UIStoryboardSegue?)
}

struct LoginRouter {
    weak var viewController: (UIViewController & LoginViewProtocol)?
}

extension LoginRouter: LoginRouterProtocol {
    func prepare(for segue: UIStoryboardSegue?) {
        guard let segue = segue else {
            return
        }

        if let controller = segue.destination as? SignUpOfferViewController {
            SignUpOfferInjector.inject(controller)
        }
    }

    func showMainVC() {

    }
}
