//
//  UIViewController+customAlert.swift
//  RateTracker
//
//  Created by Sitora on 01/07/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol CommonViewProtocol: AnyObject {
    func showAlert(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   title: String,
                   text: String,
                   options: [AlertOption])
}

extension UIViewController: CommonViewProtocol {
    func showAlert(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   title: String,
                   text: String,
                   options: [AlertOption]) {
        let alertVC = CustomAlertViewController.loadFromNib()
        alertVC.setupInfo(delegate: delegate,
                          type: type,
                          alertName: title,
                          alertText: text,
                          alertOptions: options)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC,
                                animated: true,
                                completion: nil)
    }
}
