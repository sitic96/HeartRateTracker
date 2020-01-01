//
//  String+localized.swift
//  RateTracker
//
//  Created by Sitora on 28/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
