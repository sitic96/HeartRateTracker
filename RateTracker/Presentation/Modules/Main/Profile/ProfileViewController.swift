//
//  ProfileViewController.swift
//  RateTracker
//
//  Created by Sitora on 06/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet private weak var profileContainerView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!

    var viewModel: ProfileViewModelProtocol!
    
    private var isViewFirstLoad = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // It's required when vc presented from tab controller for the first time
        // In this case view model is nil when viewWillAppear called
        if viewModel != nil {
            viewModel.viewWillAppear()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isViewFirstLoad {
            bindViewModel()
            viewModel.viewDidAppear()
            isViewFirstLoad = false
        }
    }
    
    private func bindViewModel() {
        viewModel.didUpdateUserInfo = { [weak self] in
            self?.userNameLabel.text = self?.viewModel.name
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileContainerView.cornerRadius = profileContainerView.frame.height / 2
        profileContainerView.viewBorderWidth = 3
    }
}
