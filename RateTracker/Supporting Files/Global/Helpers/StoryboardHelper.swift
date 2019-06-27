//
//  StoryboardHelper.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

struct StoryboardHelper {
    private static let storyboard = UIStoryboard(name: "SplashView",
                                                 bundle: Bundle.main)

    static func getInitialViewController() -> UIViewController? {
        return storyboard.instantiateInitialViewController()
    }
}
