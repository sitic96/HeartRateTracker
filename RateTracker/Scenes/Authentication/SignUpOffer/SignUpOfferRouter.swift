//
//  SignUpOfferRouter.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol SignUpOfferRouterProtocol {
    func prepare(for segue: UIStoryboardSegue?)
}

struct SignUpOfferRouter { }

extension SignUpOfferRouter: SignUpOfferRouterProtocol {
    func prepare(for segue: UIStoryboardSegue?) {
        guard let segue = segue else {
            return
        }

        if let controller = segue.destination as? SignUpViewController {
            SignUpInjector.inject(controller)
        }
    }

    
}
