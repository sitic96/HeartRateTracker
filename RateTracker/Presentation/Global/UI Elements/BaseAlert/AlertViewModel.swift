//
//  AlertViewModel.swift
//  RateTracker
//
//  Created by Sitora on 22/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

enum AlertOption {
    case ok // green ok button
    case defaultOk // black ok button
    case cancel
    
    func title() -> String {
        switch self {
        case .cancel:
            return "Cancel"
        case .ok, .defaultOk:
            return "OK"
        }
    }
}

enum AlertType: String {
    case ok
    case error
    
    func title() -> String {
        switch self {
        case .ok:
            return "OK"
        case .error:
            return "Error"
        }
    }
}

protocol AlertViewModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var options: [(option: AlertOption, text: String)] { get }
    var type: AlertType { get }
}

class AlertViewModel {
    private let alertOptions: [AlertOption]
    private let alertType: AlertType
    private let alertTitle: String
    private let alertSubtitle: String
    
    init(type: AlertType, options: [AlertOption],
         title: String, subtitle: String? = "") {
        self.alertType = type
        self.alertOptions = options
        self.alertTitle = title
        self.alertSubtitle = subtitle ?? ""
    }
}

extension AlertViewModel: AlertViewModelProtocol {
    var title: String {
        return alertTitle
    }
    
    var subtitle: String {
        return alertSubtitle
    }
    
    var options: [(option: AlertOption, text: String)] {
        return alertOptions.map { return (option: $0, text: $0.title())}
    }
    
    var type: AlertType {
        return alertType
    }
}
