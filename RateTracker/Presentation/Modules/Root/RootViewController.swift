//
//  RootViewController.swift
//  RateTracker
//
//  Created by Sitora on 18/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, StoryboardInstantiable {
    class var storyboardName: String {
        return "Root"
    }

    var viewModel: RootViewModelProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
}
