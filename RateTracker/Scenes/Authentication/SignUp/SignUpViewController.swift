//
//  SignUpViewController.swift
//  RateTracker
//
//  Created by Sitora on 01/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol SignUpViewProtocol: CommonViewProtocol {
    var presenter: SignUpPresenterProtocol! { get }
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!

    var presenter: SignUpPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func userDidClickSignUpButton(_ sender: UIButton) {
        presenter.viewDidClickSignUp(email: emailTextField.text,
                                     password: passwordTextField.text,
                                     repeteatedPassword: repeatPasswordTextField.text)
    }
}

extension SignUpViewController: SignUpViewProtocol {

}
