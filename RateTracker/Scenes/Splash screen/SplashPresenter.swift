//
//  SplashViewPresenter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol SplashPresenterProtocol {
    var router: SplashScreenRouterProtocol { get }
    func viewDidAppear()
}

class SplashPresenter {
    var router: SplashScreenRouterProtocol

    init(router: SplashScreenRouterProtocol) {
        self.router = router
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        // TODO - replace with initional data loading before show main vc
        router.showMainController()
    }
}
