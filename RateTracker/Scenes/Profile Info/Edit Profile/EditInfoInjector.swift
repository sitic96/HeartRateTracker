//
//  EditInfoInjector.swift
//  RateTracker
//
//  Created by Sitora on 05/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct EditInfoInjector {
    private init() { }

    static func inject<View: UIViewController & EditInfoViewProtocol>(_ view: View) {
        let router = EditInfoRouter(viewController: view)
        let userGateway = UserGateway(session: SessionManager.shared)
        let userUseCase = UserUseCase(userGateway: userGateway)
        let presenter = EditInfoPresenter(view,
                                          router: router,
                                          userUseCase: userUseCase)

        view.presenter = presenter
    }
}
