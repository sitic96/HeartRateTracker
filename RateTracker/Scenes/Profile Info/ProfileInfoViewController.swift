//
//  ProfileInfoViewController.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol ProfileInfoViewProtocol: CommonViewProtocol {
    var presenter: ProfileInfoPresenterProtocol! { get set }

    func fillInfo(for user: User)
}

class ProfileInfoViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userSecondNameLabel: UILabel!
    @IBOutlet private weak var userAgeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!


    var presenter: ProfileInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

        presenter.viewWillAppear()
        closeButton.isHidden = presenter.shouldHideCloseButton
    }
    
    @IBAction func userDidSelectChangeProfile(_ sender: UIButton) {
        presenter.viewDidSelectEditInfo()
    }
    
    @IBAction func userDidClickCloseView(_ sender: Any) {
        presenter.viewDidSelectClose()
    }
}

extension ProfileInfoViewController: ProfileInfoViewProtocol {
    func fillInfo(for user: User) {
        
    }
}
