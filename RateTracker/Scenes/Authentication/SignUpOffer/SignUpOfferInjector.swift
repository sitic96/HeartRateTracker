//
//  SignUpOfferInjector.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct SignUpOfferInjector {
    private init() { }

    static func inject<View: UIViewController & SignUpOfferViewProtocol>(_ view: View) {
        let router = SignUpOfferRouter()
        let presenter = SignUpOfferPresenter(router: router)
        view.presenter = presenter
    }
}


