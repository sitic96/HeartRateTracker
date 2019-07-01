//
//  LoginPresenter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    var view: LoginViewProtocol? { get }
    var router: LoginRouterProtocol { get }

    func viewDidClickLogin(email: String?,
                           password: String?)
    func viewDidClickSignUp()
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol

    init(_ view: LoginViewProtocol,
         router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
}
extension LoginPresenter: LoginPresenterProtocol {
    func viewDidClickLogin(email: String?,
                           password: String?) {
        guard let email = email,
            let password = password else {
                view?.showAlert(delegate: nil,
                                 type: .error,
                                 title: LocalizableKeys.error.localized,
                                 text: LocalizableKeys.emptyLoginFields.localized,
                                 options: [AlertOption(text: LocalizableKeys.ok.localized)])
                return
        }
        if !EmailValidator.validate(email: email,
                                    allowTopLevelDomains: true,
                                    allowInternational: true) {
            view?.showAlert(delegate: nil,
                             type: .error,
                             title: LocalizableKeys.error.localized,
                             text: LocalizableKeys.wrongEmail.localized,
                             options: [AlertOption(text: LocalizableKeys.ok.localized)])
        } else if password.count < 6 {
            view?.showAlert(delegate: nil,
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
