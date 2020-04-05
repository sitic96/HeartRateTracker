//
//  RecordViewCell.swift
//  RateTracker
//
//  Created by Sitora Guliamova on 4/5/20.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class RecordViewCell: UITableViewCell {
    class var identifier: String {
        return "recordViewCell"
    }

    @IBOutlet private weak var titleLabel: UILabel!

    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
}
