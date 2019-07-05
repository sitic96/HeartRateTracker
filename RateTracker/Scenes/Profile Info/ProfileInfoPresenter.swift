//
//  ProfileInfoPresenter.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol ProfileInfoPresenterProtocol {
    var router: ProfileInfoRouterProtocol { get }
    var shouldHideCloseButton: Bool { get }

    func viewDidLoad()
    func viewWillAppear()

    func viewDidSelectEditInfo()
    func viewDidSelectClose()
}

class ProfileInfoPresenter {
    private weak var view: ProfileInfoViewProtocol?
    var router: ProfileInfoRouterProtocol
    private let userUseCase: UserUseCaseProtocol

    init(_ view: ProfileInfoViewProtocol,
         router: ProfileInfoRouterProtocol,
         userUseCase: UserUseCaseProtocol) {
        self.view = view
        self.router = router
        self.userUseCase = userUseCase
    }
}

extension ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    var shouldHideCloseButton: Bool {
        return !userUseCase.isUserFirstLaunchApp
    }

    func viewDidLoad() {
        if userUseCase.isUserFirstLaunchApp {
            router.showEditProfileVC(animated: false)
        }
    }

    func viewWillAppear() {
        view?.fillInfo(for: userUseCase.currentUser)
    }

    func viewDidSelectEditInfo() {
        router.showEditProfileVC(animated: true)
    }

    func viewDidSelectClose() {
        router.showMainVC()
    }
}
