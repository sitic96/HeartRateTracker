//
//  LoginRouter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol LoginRouterProtocol {
    func showMainVC()
    func showSignUpVC()
    func showAlert(delegate: CustomAlertDelegate,
                   type: AlertType,
                   title: String,
                   text: String,
                   options: [AlertOption])
}

struct LoginRouter { }

extension LoginRouter: LoginRouterProtocol {
    func showMainVC() {

    }

    func showSignUpVC() {

    }

    func showAlert(delegate: CustomAlertDelegate,
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
    }
}
