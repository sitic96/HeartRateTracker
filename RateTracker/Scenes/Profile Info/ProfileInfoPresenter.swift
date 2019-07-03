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

    func viewWillAppear(_ view: ProfileInfoViewProtocol)

    func viewDidSelectEditInfo()
}

class ProfileInfoPresenter {
    private weak var view: ProfileInfoViewProtocol?
    var router: ProfileInfoRouterProtocol

    init(_ view: ProfileInfoViewProtocol,
         router: ProfileInfoRouterProtocol) {
        self.router = router
    }
}

extension ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    func viewWillAppear(_ view: ProfileInfoViewProtocol) {

    }

    func viewDidSelectEditInfo() {
        
    }
}
