//
//  ProfileViewModel.swift
//  RateTracker
//
//  Created by Sitora on 06/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import Firebase

protocol ProfileViewModelProtocol {
    func viewDidAppear()
}

class ProfileViewModel {
    private var ref: DatabaseReference!

    init() {
        ref = Database.database().reference()
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func viewDidAppear() {
    }
}
