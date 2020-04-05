//
//  UnderlinedLabel.swift
//  RateTracker
//
//  Created by Sitora on 06/12/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

class UnderlinedTextField: UIView, NibLoadable {
    @IBOutlet weak var textField: UITextField!

    @IBInspectable var shouldHideText: Bool = false {
        didSet {
            textField.isSecureTextEntry = shouldHideText
        }
    }

    @IBInspectable var placeholder: String = "" {
        didSet {
            self.textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        return textField.text
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        commonInit()
    }

    private func commonInit() {
//        self.textField.attributedPlaceholder =
//            NSAttributedString(string: placeholder,
//                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //self.textField.placeholder = placeholder
    }
}
