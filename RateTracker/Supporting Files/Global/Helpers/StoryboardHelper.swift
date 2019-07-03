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

    static func getLoginViewController() -> UIViewController? {
        let loginStoryboard = UIStoryboard(name: "Authentication",
                                                  bundle: Bundle.main)
        return loginStoryboard.instantiateInitialViewController()
    }

    static func getProfileInfoViewController() -> UIViewController? {
        let profileInfoStoryboard = UIStoryboard(name: "ProfileInfo",
                                                 bundle: .main)
        return profileInfoStoryboard.instantiateInitialViewController()
    }
}
