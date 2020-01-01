//
//  AuthViewController.swift
//  RateTracker
//
//  Created by Sitora on 10/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!

    @IBAction func createAccountButtonClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width,
                                            y: 0), animated: true)
    }

    @IBAction func alreadyMemberClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0,
                                            y: 0), animated: true)
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
    }

    @IBAction func skipButtonClicked(_ sender: Any) {
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
    }
}
