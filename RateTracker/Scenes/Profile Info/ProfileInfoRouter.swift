//
//  ProfileInfoRouter.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol ProfileInfoRouterProtocol {
    func showEditProfileVC(animated: Bool)
    func showMainVC()
}

struct ProfileInfoRouter {
    weak var viewController: (UIViewController & ProfileInfoViewProtocol)?
}

extension ProfileInfoRouter: ProfileInfoRouterProtocol {
    func showEditProfileVC(animated: Bool) {
        guard let vc = StoryboardHelper.getEditProfileViewController(),
            let editViewController = vc as? EditInfoViewController else {
                return
        }
        EditInfoInjector.inject(editViewController)
        viewController?.navigationController?.pushViewController(editViewController, animated: animated)
    }

    func showMainVC() {
        guard let mainVC = StoryboardHelper.getMainViewController() else {
            return
        }
        viewController?.present(mainVC, animated: true, completion: nil)
    }
}
