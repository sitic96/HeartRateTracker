//
//  SignUpPresenter.swift
//  RateTracker
//
//  Created by Sitora on 01/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol SignUpPresenterProtocol {
    var view: SignUpViewProtocol? { get }
    var router: SignUpRouterProtocol { get }

    func viewDidClickSignUp(email: String?,
                            password: String?,
                            repeteatedPassword: String?)
}

class SignUpPresenter {
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol

    private var authUseCase: AuthenticationUseCaseProtocol

    init(_ view: SignUpViewProtocol,
         router: SignUpRouterProtocol,
        authUseCase: AuthenticationUseCaseProtocol) {
        self.view = view
        self.router = router
        self.authUseCase = authUseCase
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    func viewDidClickSignUp(email: String?,
                            password: String?,
                            repeteatedPassword: String?) {
        guard let email = email,
        let password = password,
        let repeteatedPassword = repeteatedPassword else {
            view?.showAlert(delegate: nil,
                            type: .error,
                            title: LocalizableKeys.error.localized,
                            text: LocalizableKeys.emptyLoginFields.localized,
                            options: [AlertOption(text: LocalizableKeys.ok.localized)])
            return
        }
        if password != repeteatedPassword {
            view?.showAlert(delegate: nil,
                            type: .error,
                            title: LocalizableKeys.error.localized,
                            text: LocalizableKeys.passwordNotMatch.localized,
                            options: [AlertOption(text: LocalizableKeys.ok.localized)])
        } else if !EmailValidator.validate(email: email,
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
            authUseCase.signup(with: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    self?.router.showMainVC()
                case .failure(let error):
                    self?.view?.showAlert(delegate: nil,
                                    type: .error,
                                    title: LocalizableKeys.error.localized,
                                    text: error.localizedDescription,
                                    options: [AlertOption(text: LocalizableKeys.ok.localized)])
                }
            }
        }
    }
}