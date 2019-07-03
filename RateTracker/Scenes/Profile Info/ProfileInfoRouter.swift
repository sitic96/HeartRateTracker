//
//  ProfileInfoRouter.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol ProfileInfoRouterProtocol {
    func showEditProfileVC()
}

struct ProfileInfoRouter {
    weak var viewController: (UIViewController & ProfileInfoViewProtocol)?

}

extension ProfileInfoRouter: ProfileInfoRouterProtocol {
    func showEditProfileVC() {
        guard let vc = StoryboardHelper.getEditProfileViewController(),
            let editViewController = vc as? EditProfileViewController else {
                return
        }
        viewController?.navigationController?.pushViewController(editViewController, animated: false)
    }
}
