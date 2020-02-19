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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileContainerView.cornerRadius = profileContainerView.frame.height / 2
        profileContainerView.viewBorderWidth = 3
        userNameLabel.text = "Sitora Guliamova"
    }
}
