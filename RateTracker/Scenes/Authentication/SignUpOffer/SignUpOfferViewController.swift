//
//  SignUpOfferViewController.swift
//  RateTracker
//
//  Created by Sitora on 02/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol SignUpOfferViewProtocol: CommonViewProtocol {
    var presenter: SignUpOfferPresenterProtocol! { get set }
}

class SignUpOfferViewController: UIViewController {

    var presenter: SignUpOfferPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue)
    }

}

extension SignUpOfferViewController: SignUpOfferViewProtocol {

}
