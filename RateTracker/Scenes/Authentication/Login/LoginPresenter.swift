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
                router.showAlert(delegate: nil,
                                 type: .error,
                                 title: LocalizableKeys.error.localized,
                                 text: LocalizableKeys.emptyLoginFields.localized,
                                 options: [AlertOption(text: LocalizableKeys.ok.localized)])
                return
        }
        if !EmailValidator.validate(email: email,
                                    allowTopLevelDomains: true,
                                    allowInternational: true) {
            router.showAlert(delegate: nil,
                             type: .error,
                             title: LocalizableKeys.error.localized,
                             text: LocalizableKeys.wrongEmail.localized,
                             options: [AlertOption(text: LocalizableKeys.ok.localized)])
        } else if password.count < 6 {
            router.showAlert(delegate: nil,
                             type: .error,
                             title: LocalizableKeys.error.localized,
                             text: LocalizableKeys.shortPassword.localized,
                             options: [AlertOption(text: LocalizableKeys.ok.localized)])
        } else {
            // data is ok, try to login
        }
    }

    func viewDidClickSignUp() {
        router.showSignUpVC()
    }
}
