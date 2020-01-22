//
//  Coordinator.swift
//  RateTracker
//
//  Created by Sitora on 18/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import UIKit

class Coordinator: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
    
    func showError(errorMessage: String) {
        let vc = AlertViewController.instantiateViewController(storyboardId: AlertViewController.storyboardId)
        let alertViewModel = AlertViewModel(type: .error,
                                            options: [.defaultOk],
                                            title: AlertType.error.title(),
                                            subtitle: errorMessage)
        vc.viewModel = alertViewModel
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
