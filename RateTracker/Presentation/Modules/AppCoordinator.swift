//
//  AppCoordinator.swift
//  RateTracker
//
//  Created by Sitora on 01/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
