//
//  LoginViewController.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol! { get set }
}

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var presenter: LoginPresenterProtocol!

    @IBAction func userDidClickSignUp(_ sender: Any) {
        presenter.viewDidClickSignUp()
    }

    @IBAction func userDidClickLogin(_ sender: UIButton) {
        presenter.viewDidClickLogin(email: emailAddressTextField.text,
                                    password: passwordTextField.text)
    }
}

extension LoginViewController: LoginViewProtocol {

}
