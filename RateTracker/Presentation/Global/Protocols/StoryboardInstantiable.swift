//
//  StoryboardInstantiable.swift
//  RateTracker
//
//  Created by Sitora on 18/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype MyType
    static func instantiateViewController(storyboardId: String,
                                          _ bundle: Bundle?) -> MyType
}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiateViewController(storyboardId: String,
                                          _ bundle: Bundle? = nil) -> Self {
        let fileName = storyboardId
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! Self
    }
}

