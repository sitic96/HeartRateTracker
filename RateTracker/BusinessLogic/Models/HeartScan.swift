//
//  ScanSession.swift
//  RateTracker
//
//  Created by Sitora on 05/02/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

struct HeartScan {
    let startedAt: Date
    var finishedAt: Date?
    let sensorPosition: SensorPosition
    var data: [HeartData]
    var notes: String?
    var name: String?

    init(startedAt: Date,
         sensorPosition: SensorPosition) {
        self.startedAt = startedAt
        self.sensorPosition = sensorPosition
        self.data = []
    }

    init(startedAt: Date,
         finishedAt: Date,
         sensorPosition: SensorPosition,
         data: [HeartData],
         notes: String? = "",
         name: String? = "") {
        self.startedAt = startedAt
        self.finishedAt = finishedAt
        self.sensorPosition = sensorPosition
        self.data = data
        self.notes = notes
        self.name = name
    }
}
