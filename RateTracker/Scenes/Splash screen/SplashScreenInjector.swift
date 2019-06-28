//
//  SplashScreenInjector.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct SplashScreenInjector {
    private init() { }

    static func inject<View: UIViewController & SplashScreenViewProtocol>(_ view: View) {
        let splashRouter = SplashScreenRouter(viewController: view)
        let presenter = SplashPresenter(router: splashRouter)
        view.presenter = presenter
    }
}
