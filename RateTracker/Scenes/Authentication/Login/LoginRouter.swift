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
    func showAlert(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   title: String,
                   text: String,
                   options: [AlertOption])
}

struct LoginRouter {
    weak var viewController: (UIViewController & LoginViewProtocol)?
}

extension LoginRouter: LoginRouterProtocol {
    func showMainVC() {

    }

    func showSignUpVC() {

    }

    func showAlert(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   title: String,
                   text: String,
                   options: [AlertOption]) {
        let alertVC = CustomAlertViewController.loadFromNib()
        alertVC.setupInfo(delegate: delegate,
                          type: type,
                          alertName: title,
                          alertText: text,
                          alertOptions: options)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        viewController?.present(alertVC,
                                animated: true,
                                completion: nil)
    }
}
