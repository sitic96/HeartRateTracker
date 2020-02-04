//
//  HeartManager.swift
//  RateTracker
//
//  Created by Sitora on 31/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HeartManagerProtocol {
    var sensorPosition: BehaviorRelay<SensorPosition> { get }
    var heartData: BehaviorRelay<[HeartData]> { get }
    func start()
    func pause()
    func resume()
    func stop()
}

class HeartManager {
    static let shared = HeartManager()

    private let saveManager: HeartDataSaveManagerProtocol
    private var bleManager: BluetoothManagerProtocol
    var sensorPosition = BehaviorRelay<SensorPosition>(value: .unknown)
    
    // Current session data
    lazy var heartData = BehaviorRelay<[HeartData]>(value: [])

    private init() {
        bleManager = BluetoothManager.shared
        saveManager = HeartDataSaveManager(coreData: CoreDataManager.shared)
    }

    private func sensorLocation(from data: Data?) -> SensorPosition {
        guard let characteristicData = data,
            let byte = characteristicData.first else {
                return .unknown
        }
        return SensorPosition(byte: byte)
    }

    private func heartData(from data: Data?) -> HeartData? {
        guard let characteristicData = data else {
            return nil
        }
        var offset = 1
        var bpm = 0
        let byteArray = [UInt8](characteristicData)


        let firstBitValue = byteArray[0] & 0x01
        if firstBitValue == 0 {
            bpm = Int(byteArray[1])
            offset = offset + 1
        } else {
            bpm = (Int(byteArray[1]) << 8) + Int(byteArray[2])
            offset = offset + 2
        }

        if ((byteArray[0] & 0x03) == 1) {
            offset =  offset + 2
        }

        var rrValues = [Double]()
        if !((byteArray[0] & 0x04) == 0) {
            let count = (characteristicData.count - offset)/2
            var offset1 = 0
            for _ in 0..<count {
                let bigEndianValue = [byteArray[byteArray.count - (offset1 + 1)],
                                      byteArray[byteArray.count - (offset1 + 2)]]
                    .withUnsafeBufferPointer {
                        ($0.baseAddress!.withMemoryRebound(to: UInt16.self, capacity: 1) { $0 })
                }.pointee
                rrValues.append(Double(UInt16(bigEndian: bigEndianValue)) / 1024.0)
                offset1 = offset1 + 2
            }
        }
        return HeartData(bpm: bpm, rrValues: rrValues, date: Date())
    }

    private func onNewValue(_ data: Data?) {
        guard let heartInfo = heartData(from: data) else {
            return
        }
        saveManager.save(heartInfo) { [weak self] result in
            if let strongSelf = self {
                switch result {
                case .success:
                    strongSelf.heartData.accept(strongSelf.heartData.value
                        + [heartInfo])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func onPositionValue(_ data: Data?) {
        let newLocation = sensorLocation(from: data)
        if sensorPosition.value != newLocation {
            sensorPosition.accept(newLocation)
        }
    }
}

extension HeartManager: HeartManagerProtocol {
    func start() {
        bleManager.startListening()
        bleManager.didReciveNewValue = onNewValue(_:)
        bleManager.didRecivePosition = onPositionValue(_:)
    }
    
    func pause() {
        bleManager.pause()
    }

    func resume() {
        bleManager.resume()
    }

    func stop() {
        bleManager.stopListening()
    }
}
