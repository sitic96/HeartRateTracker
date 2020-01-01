//
//  UIViewController+loadFromNib.swift
//  RateTracker
//
//  Created by Sitora on 28/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit
 
extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
