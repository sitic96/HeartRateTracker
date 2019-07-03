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

    func viewDidLoad()
    func viewWillAppear(_ view: ProfileInfoViewProtocol)

    func viewDidSelectEditInfo()
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
    func viewDidLoad() {
        if userUseCase.isUserFirstLaunchApp {
            router.showEditProfileVC()
        }
    }

    func viewWillAppear(_ view: ProfileInfoViewProtocol) {

    }

    func viewDidSelectEditInfo() {
        router.showEditProfileVC()
    }
}
