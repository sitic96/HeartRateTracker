//
//  LoginViewController.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: CommonViewProtocol {
    var presenter: LoginPresenterProtocol! { get set }
}

class LoginViewController: UIViewController {
    @IBOutlet private weak var emailAddressTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    var presenter: LoginPresenterProtocol!

    @IBAction func userDidClickLogin(_ sender: UIButton) {
        presenter.viewDidClickLogin(email: emailAddressTextField.text,
                                    password: passwordTextField.text)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue)
    }
}

extension LoginViewController: LoginViewProtocol {

}
