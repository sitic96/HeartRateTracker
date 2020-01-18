//
//  AppDelegate.swift
//  RateTracker
//
//  Created by Sitora Guliamova on 1/30/19.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        launchRootCoordinator()
        return true
    }
    
    private func launchRootCoordinator() {
        let coordinator = RootCoordinator()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator
        window?.makeKeyAndVisible()
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}

