//
//  CustomAlertViewController.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

enum AlertType {
    case error
    case info
    case ok
}

struct AlertOption {
    var tag: Int?
    let textColor: UIColor?
    let text: String

    init(textColor: UIColor? = nil,
         text: String) {
        self.textColor = textColor
        self.text = text
    }
}

protocol CustomAlertDelegate: AnyObject {
    func usedDidSelectOption(_ option: AlertOption)
}

protocol CustomAlertViewProtocol {
    func setupInfo(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   alertName: String?,
                   alertText: String?,
                   alertOptions: [AlertOption])
}

class CustomAlertViewController: UIViewController {
    private weak var delegate: CustomAlertDelegate?
    private var alertOptions: [AlertOption]?

    @IBOutlet weak var typeIndicatorView: UIView!
    @IBOutlet weak var alertNameLabel: UILabel!

    @IBOutlet private weak var alertTextLabel: UILabel!
    @IBOutlet private weak var optionsStackView: UIStackView!

    @objc private func userDidSelectOption(_ sender: UIButton) {
        if let alertOptions = alertOptions,
            sender.tag < alertOptions.count {
            delegate?.usedDidSelectOption(alertOptions[sender.tag])
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension CustomAlertViewController: CustomAlertViewProtocol {
    func setupInfo(delegate: CustomAlertDelegate?,
                   type: AlertType,
                   alertName: String?,
                   alertText: String?,
                   alertOptions: [AlertOption]) {
         _ = self.view
        self.delegate = delegate
        self.alertOptions = alertOptions

        switch type {
        case .error:
            typeIndicatorView.backgroundColor = .red
        case .info:
            typeIndicatorView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .ok:
            typeIndicatorView.backgroundColor = .green

        }

        alertNameLabel.text = alertName
        alertTextLabel.text = alertText

        for i in 0..<alertOptions.count {
            let optionButton = UIButton()
            optionButton.setTitle(alertOptions[i].text, for: .normal)
            optionButton.setTitleColor(alertOptions[i].textColor ?? .black,
                                       for: .normal)
            optionButton.addTarget(self,
                                   action: #selector(userDidSelectOption(_:)),
                                   for: .touchUpInside)
            optionButton.tag = i

            optionsStackView.addArrangedSubview(optionButton)
        }
    }
}

