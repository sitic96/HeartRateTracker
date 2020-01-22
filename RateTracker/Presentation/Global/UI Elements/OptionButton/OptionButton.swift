//
//  OptionButton.swift
//  RateTracker
//
//  Created by Sitora on 22/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class OptionButton: RTButton {
    func setup(type: AlertOption, text: String) {
        self.setTitle(text, for: .normal)

        switch type {
        case .cancel:
            self.setTitleColor(Palette.errorColor, for: .normal)
        case .ok:
            self.setTitleColor(Palette.okColor, for: .normal)
        case .defaultOk:
            self.setTitleColor(Palette.blackColor, for: .normal)
        }
    }
}
