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

    private lazy var pastRecordsViewModel: PastRecordsViewModelProtocol = {
        return PastRecordsViewModel(scanSaveManager: HeartScanSaveManager.shared)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach {
            switch $0 {
            case let vc as ProfileViewController:
                vc.viewModel = profileViewModel
            case let vc as PastRecordsViewController:
                vc.viewModel = pastRecordsViewModel
            default:
                break
            }
        }
    }
}
