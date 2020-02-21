//
//  AuthCoordinator.swift
//  RateTracker
//
//  Created by Sitora on 01/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
    func showMainController()
}

class AuthCoordinator: Coordinator {
    override init() {
        super.init()
        let vc = AuthViewController.instantiateViewController(storyboardId: AuthViewController.storyboardIdentifier)
        vc.viewModel = AuthViewModel(coordinator: self,
                                     userSaveManager: UserSaveManager())
        pushViewController(vc, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func showMainController() {
        if let vc = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() {
            vc.modalPresentationStyle = .overFullScreen
            pushViewController(vc, animated: true)
        }
    }
}
