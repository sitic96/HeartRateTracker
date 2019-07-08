//
//  SignUpRouter.swift
//  RateTracker
//
//  Created by Sitora on 01/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol SignUpRouterProtocol {
    func showMainVC()
}

struct SignUpRouter {
    weak var viewController: (UIViewController & SignUpViewProtocol)?
}

extension SignUpRouter: SignUpRouterProtocol {
    func showMainVC() {
        guard let mainVC = StoryboardHelper.getMainViewController() else {
            return
        }
        viewController?.present(mainVC, animated: true, completion: nil)
    }
}
