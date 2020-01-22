//
//  AlertViewController.swift
//  RateTracker
//
//  Created by Sitora on 22/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, StoryboardInstantiable {

    class var storyboardId: String {
        return "Alert"
    }

    @IBOutlet private weak var topColorView: UIView!
    @IBOutlet private weak var alertIconImageView: UIImageView!
    @IBOutlet private weak var alertTitleLabel: UILabel!
    @IBOutlet private weak var alertSubtitleLabel: UILabel!
    @IBOutlet private weak var optionsStackView: UIStackView!

    var viewModel: AlertViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alertTitleLabel.text = viewModel.title
        self.alertSubtitleLabel.text = viewModel.subtitle

        for item in viewModel.options {
            let optionButton = OptionButton()
            optionButton.setup(type: item.option, text: item.text)
            optionButton.addTarget(self,
                                   action: #selector(userDidSelectAlertOption(sender:)),
                                   for: .touchUpInside)
            optionsStackView.addArrangedSubview(optionButton)
        }

        switch viewModel.type {
        case .ok:
            topColorView.backgroundColor = Palette.okColor.withAlphaComponent(0.2)
        case .error:
            topColorView.backgroundColor = Palette.errorColor.withAlphaComponent(0.2)
        }
    }

    @objc private func userDidSelectAlertOption(sender: OptionButton) {
        dismiss(animated: true, completion: nil)
    }
}
