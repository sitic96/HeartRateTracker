//
//  ProfileInfoInjector.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct ProfileInfoInjector {
    private init() { }

    static func inject<View: UIViewController & ProfileInfoViewProtocol>(_ view: View) {
        let router = ProfileInfoRouter(viewController: view)
        let userGateway = UserGateway(session: SessionManager.shared)
        let userUseCase = UserUseCase(userGateway: userGateway)

        let presenter = ProfileInfoPresenter(view,
                                             router: router,
                                             userUseCase: userUseCase)
        view.presenter = presenter
    }
}
