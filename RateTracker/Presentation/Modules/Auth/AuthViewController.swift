//
//  AuthViewController.swift
//  RateTracker
//
//  Created by Sitora on 10/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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

    private var currentResponder: UITextField?


    var viewModel: AuthViewModelProtocol!
    private var shownPage: ShownPage = .login
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        nameSignUpTextView.textField.delegate = self
        emailSignUpTextField.textField.delegate = self
        passwordSignUpTextField.textField.delegate = self
        emailLoginTextField.textField.delegate = self
        passwordLoginTextField.textField.delegate = self
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.isLoading
            .bind(to: self.signUpRTButton.rx.isLoading)
            .disposed(by: bag)
        viewModel.isLoading
        .bind(to: self.loginRTButton.rx.isLoading)
        .disposed(by: bag)
    }

    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentResponder?.resignFirstResponder()
    }

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
        viewModel.viewDidSelectLogin(email: emailLoginTextField.text,
                                     password: passwordLoginTextField.text)
    }

    @IBAction func skipButtonClicked(_ sender: Any) {
        viewModel.viewDidSelectSkip()
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        viewModel.viewDidSelectSignUp(name: nameSignUpTextView.text,
                                      email: emailSignUpTextField.text,
                                      password: passwordSignUpTextField.text)
    }

    // MARK: - Private
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentResponder = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
