//
//  SensorPosition.swift
//  RateTracker
//
//  Created by Sitora on 30/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

enum SensorPosition: String {
    case chest
    case wrist
    case finger
    case hand
    case earLobe
    case foot
    case unknown

    init(from string: String) {
        switch string.lowercased() {
        case "chest":
            self = .chest
        case "wrist":
            self = .wrist
        case "finger":
            self = .finger
        case "hand":
            self = .hand
        case "earLobe":
            self = .earLobe
        case "foot":
            self = .foot
        default:
            self = .unknown
        }
    }

    init(byte: Data.Element) {
        switch byte {
        case 0:
            self = .unknown
        case 1:
            self = .chest
        case 2:
            self = .wrist
        case 3:
            self = .finger
        case 4:
            self = .hand
        case 5:
            self = .earLobe
        case 6:
            self = .foot
        default:
            self = .unknown
        }
    }

    func localized() -> String {
        switch self {
        case .chest:
            return LocalizableKeys.BLE.chest.localized
        case .wrist:
            return LocalizableKeys.BLE.wrist.localized
        case .finger:
            return LocalizableKeys.BLE.finger.localized
        case .hand:
            return LocalizableKeys.BLE.hand.localized
        case .earLobe:
            return LocalizableKeys.BLE.earLobe.localized
        case .foot:
            return LocalizableKeys.BLE.foot.localized
        case .unknown:
            return LocalizableKeys.BLE.unknown.localized
        }
    }
}
