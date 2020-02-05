//
//  SaveManager.swift
//  RateTracker
//
//  Created by Sitora on 04/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

typealias SaveManagerCompletion = (Result<Void, Error>) -> Void

class SaveManager {
    func startOfTheDay(for date: Date) -> NSDate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        return calendar.startOfDay(for: date) as NSDate
    }

    func endOfTheDay(for date: Date) -> NSDate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)! as NSDate
    }
}
