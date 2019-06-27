//
//  AppDelegate.swift
//  RateTracker
//
//  Created by Sitora Guliamova on 1/30/19.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let splashViewController = StoryboardHelper.getInitialViewController() as? SplashViewController {

            SplashScreenInjector.inject(splashViewController)

            window?.rootViewController = splashViewController
            window?.makeKeyAndVisible()
        }
        return true
    }
}

