//
//  EditProfileViewController.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var dateOfBirthPickerView: UIDatePicker!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        dateOfBirthPickerView.maximumDate = Date()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func userDidSelectUpdatePhoto(_ sender: Any) {
    }

    @IBAction func userDidFinishEditProfile(_ sender: Any) {
    }
}
