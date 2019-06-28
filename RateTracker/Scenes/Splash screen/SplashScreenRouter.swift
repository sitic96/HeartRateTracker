//
//  SplashScreenRouter.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol SplashScreenRouterProtocol {
    func showMainController()
}

struct SplashScreenRouter {
    weak var viewController: (UIViewController & SplashScreenViewProtocol)?
}

extension SplashScreenRouter: SplashScreenRouterProtocol {
    func showMainController() {
        // TODO: if user already login - show main vc
        // Otherwise show login flow
        guard let viewController = StoryboardHelper.getLoginViewController(),
        let loginVC = viewController as? LoginViewController else {
            return
        }
        LoginInjector.inject(loginVC)

        UIApplication.shared.keyWindow?.rootViewController?.present(loginVC,
                                                                    animated: true,
                                                                    completion: nil)
//        viewController.present(loginVC,
//                               animated: true,
//                               completion: nil)
    }
}
