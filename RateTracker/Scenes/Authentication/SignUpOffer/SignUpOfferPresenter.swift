//
//  SignUpOfferPresenter.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol SignUpOfferPresenterProtocol {
    var router: SignUpOfferRouterProtocol { get }
}

class SignUpOfferPresenter {
    var router: SignUpOfferRouterProtocol

    init(router: SignUpOfferRouterProtocol) {
        self.router = router
    }
}

extension SignUpOfferPresenter: SignUpOfferPresenterProtocol {
    
}
