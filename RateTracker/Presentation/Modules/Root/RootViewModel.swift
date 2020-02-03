//
//  RootViewModel.swift
//  RateTracker
//
//  Created by Sitora on 18/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase

protocol RootViewModelProtocol {
    func viewDidAppear()
}

class RootViewModel {
    private weak var coordinator: RootCoordinatorProtocol?

    init(coordinator: RootCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension RootViewModel: RootViewModelProtocol {
    func viewDidAppear() {
        if Auth.auth().currentUser != nil {
            coordinator?.showMainView()
        } else {
            coordinator?.showAuthView()
        }
    }
}
