//
//  EditInfoRouter.swift
//  RateTracker
//
//  Created by Sitora on 05/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol EditInfoRouterProtocol {
    func backToInfoVC()
}

struct EditInfoRouter {
    weak var viewController: (UIViewController & EditInfoViewProtocol)?
}

extension EditInfoRouter: EditInfoRouterProtocol {
    func backToInfoVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
