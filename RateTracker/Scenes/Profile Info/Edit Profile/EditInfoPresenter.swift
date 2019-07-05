//
//  EditInfoPresenter.swift
//  RateTracker
//
//  Created by Sitora on 05/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol EditInfoPresenterProtocol {
    var view: EditInfoViewProtocol? { get }
    var router: EditInfoRouterProtocol { get }

    func viewDidLoad()
    func viewDidFinishEditProfile(name: String?,
                                  secondName: String?,
                                  email: String?,
                                  dateOfBirth: Date)
    func viewDidSelectUpdatePhoto()
}

class EditInfoPresenter {
    weak var view: EditInfoViewProtocol?
    var router: EditInfoRouterProtocol

    private var userUseCase: UserUseCaseProtocol

    init(_ view: EditInfoViewProtocol,
         router: EditInfoRouterProtocol,
         userUseCase: UserUseCaseProtocol) {
        self.view = view
        self.router = router
        self.userUseCase = userUseCase
    }
}

extension EditInfoPresenter: EditInfoPresenterProtocol {
    func viewDidLoad() {
        view?.fillInfo(for: userUseCase.currentUser)
    }

    func viewDidFinishEditProfile(name: String?,
                                  secondName: String?,
                                  email: String?,
                                  dateOfBirth: Date) {
        if let email = email,
            !email.isEmpty {
            if !EmailValidator.validate(email: email) {
                view?.showAlert(delegate: nil,
                                type: .error,
                                title: LocalizableKeys.error.localized,
                                text: LocalizableKeys.wrongEmail.localized,
                                options: [AlertOption(text: LocalizableKeys.ok.localized)])
            }
        }
        var newUser = User()
        newUser.name = name
        newUser.secondName = secondName
        newUser.email = email
        newUser.birthDate = dateOfBirth

        userUseCase.updateUserInfo(newInfo: newUser)
        router.backToInfoVC()
    }

    func viewDidSelectUpdatePhoto() {

    }
}
