//
//  RootCoordinator.swift
//  RateTracker
//
//  Created by Sitora on 18/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol RootCoordinatorProtocol: AnyObject {
    func showMainView()
    func showAuthView()
}

class RootCoordinator: Coordinator {
    override init() {
        super.init()
        let vc = RootViewController.instantiateViewController(storyboardId: RootViewController.storyboardName)
        vc.viewModel = RootViewModel(coordinator: self)
        pushViewController(vc, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootCoordinator: RootCoordinatorProtocol {
    func showMainView() {

    }

    func showAuthView() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.modalPresentationStyle = .overFullScreen
        authCoordinator.modalTransitionStyle = .crossDissolve
        present(authCoordinator, animated: true, completion: nil)
    }
}
