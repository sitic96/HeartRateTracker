//
//  AuthViewController.swift
//  RateTracker
//
//  Created by Sitora on 10/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

fileprivate enum ShownPage {
    case login
    case signUp
}

class AuthViewController: UIViewController, StoryboardInstantiable {
    class var storyboardIdentifier: String {
        return "Auth"
    }

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginErrorLabel: UILabel!
    @IBOutlet private weak var signUpErrorLabel: UILabel!
    @IBOutlet private weak var nameSignUpTextView: UnderlinedTextField!
    @IBOutlet private weak var emailSignUpTextField: UnderlinedTextField!
    @IBOutlet private weak var passwordSignUpTextField: UnderlinedTextField!
    @IBOutlet private weak var emailLoginTextField: UnderlinedTextField!
    @IBOutlet private weak var passwordLoginTextField: UnderlinedTextField!
    @IBOutlet private weak var signUpRTButton: RTButton!
    @IBOutlet private weak var loginRTButton: RTButton!

    @IBOutlet private var loginErrorLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var signupErrorLabelHeightConstraint: NSLayoutConstraint!


    var viewModel: AuthViewModelProtocol!
    private var shownPage: ShownPage = .login

    // MARK: - IBAction

    @IBAction func createAccountButtonClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width,
                                            y: 0), animated: true)
        shownPage = .signUp
    }

    @IBAction func alreadyMemberClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0,
                                            y: 0), animated: true)
        shownPage = .login
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        setupViewForLoading()
        viewModel.viewDidSelectLogin(email: emailLoginTextField.text,
                                     password: passwordLoginTextField.text)
    }

    @IBAction func skipButtonClicked(_ sender: Any) {
        viewModel.viewDidSelectSkip()
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        setupViewForLoading()
        viewModel.viewDidSelectSignUp(name: nameSignUpTextView.text,
                                      email: emailSignUpTextField.text,
                                      password: passwordSignUpTextField.text)
    }

    // MARK: - Private

    private func setupViewForLoading() {
        scrollView.isScrollEnabled = false

        switch shownPage {
        case .login:
            loginRTButton.isLoading = true
        case .signUp:
            signUpRTButton.isLoading = true
        }
    }
}

fileprivate extension Const {
    static let zeroHeight = 0
}

// MARK: - Localizable

extension AuthViewController: Localizable {
    func localize() {

    }
}
