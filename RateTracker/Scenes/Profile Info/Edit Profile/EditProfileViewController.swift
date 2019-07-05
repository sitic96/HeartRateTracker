//
//  EditProfileViewController.swift
//  RateTracker
//
//  Created by Sitora on 03/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol EditInfoViewProtocol: CommonViewProtocol {
    var presenter: EditInfoPresenterProtocol! { get set }

    func fillInfo(for user: User)
}

class EditInfoViewController: UIViewController {
    @IBOutlet private weak var profilePhotoImageView: UIImageView!
    @IBOutlet private weak var dateOfBirthPickerView: UIDatePicker!
    @IBOutlet private weak var secondNameTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!

    var presenter: EditInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        dateOfBirthPickerView.maximumDate = Date()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func userDidSelectUpdatePhoto(_ sender: Any) {
        presenter.viewDidSelectUpdatePhoto()
    }

    @IBAction func userDidFinishEditProfile(_ sender: Any) {
        presenter.viewDidFinishEditProfile(name: nameTextField.text,
                                           secondName: secondNameTextField.text,
                                           email: emailTextField.text,
                                           dateOfBirth: dateOfBirthPickerView.date)
    }
}

extension EditInfoViewController: EditInfoViewProtocol {
    func fillInfo(for user: User) {
        if let userDateOfBirth = user.birthDate {
            dateOfBirthPickerView.date = userDateOfBirth
        }
        nameTextField.text = user.name
        secondNameTextField.text = user.secondName
        emailTextField.text = user.email
    }
}
