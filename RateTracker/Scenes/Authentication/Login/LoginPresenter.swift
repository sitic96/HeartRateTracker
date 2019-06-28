//
//  LoginPresenter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    var router: LoginRouterProtocol { get }

    func viewDidClickLogin(email: String?,
                           password: String?)
    func viewDidClickSignUp()
}

class LoginPresenter {
    var router: LoginRouterProtocol

    init(router: LoginRouterProtocol) {
        self.router = router
    }
}
extension LoginPresenter: LoginPresenterProtocol {
    func viewDidClickLogin(email: String?,
                           password: String?) {
        guard let email = email,
            let password = password else {
                router.showAlert(delegate: self,
                                 type: .error,
                                 title: "Error",
                                 text: "Email or password is empty",
                                 options: [AlertOption(text: "OK")])
                return
        }
        if !EmailValidator.validate(email: email,
                                    allowTopLevelDomains: true,
                                    allowInternational: true) {
            router.showAlert(delegate: self,
                             type: .error,
                             title: "Error",
                             text: "Incorrect email",
                             options: [AlertOption(text: "OK")])
        } else if password.count < 6 {
            router.showAlert(delegate: self,
                             type: .error,
                             title: "Error",
                             text: "Password is too short",
                             options: [AlertOption(text: "OK")])
        } else {
            // data is ok, try to login
        }
    }

    func viewDidClickSignUp() {
        router.showSignUpVC()
    }
}

extension LoginPresenter: CustomAlertDelegate {
    func usedDidSelectOption(_ option: AlertOption) {

    }
}
