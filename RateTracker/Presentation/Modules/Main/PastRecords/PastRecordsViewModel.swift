//
//  PastRecordsViewModel.swift
//  RateTracker
//
//  Created by Sitora on 30/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation

protocol PastRecordsViewModelProtocol {
    var recordsCount: Int { get }
    var records: [HeartScan] { get }
    
    func viewWillAppear()
}

class PastRecordsViewModel {
    private let scanSaveManager: HeartScanSaveManagerProtocol
    var records: [HeartScan] = []
    
    init(scanSaveManager: HeartScanSaveManagerProtocol) {
        self.scanSaveManager = scanSaveManager
    }
    
    private func fetchData() {
        records = scanSaveManager.allRecords()
    }
}

extension PastRecordsViewModel: PastRecordsViewModelProtocol {
    var recordsCount: Int {
        return records.count
    }
    
    func viewWillAppear() {
        records = scanSaveManager.allRecords()
    }
}
