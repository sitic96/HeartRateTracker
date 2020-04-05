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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
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
