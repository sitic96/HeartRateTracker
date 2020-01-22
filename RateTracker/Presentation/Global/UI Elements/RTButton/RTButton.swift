//
//  RTButton.swift
//  RateTracker
//
//  Created by Sitora on 01/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RTButton: UIButton {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        self.addSubview(indicator)
        NSLayoutConstraint.activate([indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        indicator.isHidden = true
        return indicator
    }()

    var isLoading: Bool {
        set {
            activityIndicator.isHidden = !newValue
            if newValue {
                self.setTitle("", for: UIControl.State.disabled)
                activityIndicator.startAnimating()
                self.isEnabled = false
            } else {
                self.isEnabled = true
                self.setTitle(self.title(for: .normal), for: UIControl.State.disabled)
                activityIndicator.stopAnimating()
            }
        }
        get {
            return !activityIndicator.isHidden
        }
    }

    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            if newValue {
                self.alpha = 1
            } else {
                self.alpha = 0.7
            }
            super.isEnabled = newValue
        }
    }
}

extension Reactive where Base: RTButton {
    var isLoading: Binder<Bool> {
        return Binder(self.base) {
            view, isLoading in
            view.isLoading = isLoading
        }
    }
}
