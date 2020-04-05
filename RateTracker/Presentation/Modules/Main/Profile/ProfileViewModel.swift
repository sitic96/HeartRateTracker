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
    var name: String { get }
    var age: String { get }
    
    var didUpdateUserInfo: (() -> Void )? { get set }
    
    func viewWillAppear()
}

class ProfileViewModel {
    private let userSaveManager: UserSaveManagerProtocol
    private var ref: DatabaseReference!
    private var user: User?
    
    var didUpdateUserInfo: (() -> Void )?
    
    init(userSaveManager: UserSaveManagerProtocol) {
        ref = Database.database().reference()
        self.userSaveManager = userSaveManager
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    var name: String {
        return user?.name ?? ""
    }
    
    var age: String {
        if let user = user,
            let birthDate = user.birthDate {
            return "\(Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year!) y.o."
        } else {
            return ""
        }
    }
    
    func viewWillAppear() {
        user = userSaveManager.user()
        didUpdateUserInfo?()
    }
    
}
