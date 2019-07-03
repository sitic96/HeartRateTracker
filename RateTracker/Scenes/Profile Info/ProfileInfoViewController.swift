//
//  ProfileInfoViewController.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol ProfileInfoViewProtocol: CommonViewProtocol {
    var presenter: ProfileInfoPresenterProtocol! { get set}
}

class ProfileInfoViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userSecondNameLabel: UILabel!
    @IBOutlet private weak var userAgeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!

    var presenter: ProfileInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func userDidSelectChangeProfile(_ sender: UIButton) {
    }
}

extension ProfileInfoViewController: ProfileInfoViewProtocol {
    
}
