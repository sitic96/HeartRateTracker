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

struct SignUpOfferRouter {
}

extension SignUpOfferRouter: SignUpOfferRouterProtocol {
    func prepare(for segue: UIStoryboardSegue?) {
        guard let segue = segue else {
            return
        }

        // TODO: get rid of (as!)
        switch segue.destination {
        case is SignUpViewController:
            SignUpInjector.inject(segue.destination as! SignUpViewController)
        case is UINavigationController:
            if let destVC = (segue.destination as! UINavigationController).viewControllers[0] as? ProfileInfoViewController {
                ProfileInfoInjector.inject(destVC)
            }
        default:
            return
        }
    }
}
