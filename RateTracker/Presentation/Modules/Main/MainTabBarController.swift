//
//  MainTabBarController.swift
//  RateTracker
//
//  Created by Sitora on 06/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private lazy var profileViewModel: ProfileViewModelProtocol = {
        return ProfileViewModel(userSaveManager: UserSaveManager())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        switch viewController {
        case let vc as ProfileViewController:
            vc.viewModel = profileViewModel
        default:
            break
        }
    }
}
