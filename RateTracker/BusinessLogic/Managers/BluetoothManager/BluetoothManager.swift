//
//  BluetoothManager.swift
//  RateTracker
//
//  Created by Sitora on 30/01/2020.
//  Copyright © 2020 Sitora Guliamova. All rights reserved.
//

// https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor

import Foundation
import CoreBluetooth

protocol BluetoothManagerProtocol {
    var didRecivePosition: ((Data?) -> Void)? { get set }
    var didReciveNewValue: ((Data?) -> Void)? { get set }

    func startListening()
    func pause()
    func resume()
    func stopListening()
}

class BluetoothManager: NSObject {
    static let shared = BluetoothManager()

    var didRecivePosition: ((Data?) -> Void)?
    var didReciveNewValue: ((Data?) -> Void)?

    private var centralManager: CBCentralManager!
    private var heartRatePeripheral: CBPeripheral?
    private var centralManagerState: CBManagerState = .unknown
    private var sensorPosition: SensorPosition = .unknown
    private let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    private let heartRateMeasurementCharacteristicCBUUID = CBUUID(string: "2A37")
    private let bodySensorLocationCharacteristicCBUUID = CBUUID(string: "2A38")
    private var subscribedCharacteristic: CBCharacteristic?

    private override init() { }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralManagerState = central.state

        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [heartRateServiceCBUUID], options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        heartRatePeripheral = peripheral
        heartRatePeripheral!.delegate = self
        centralManager.stopScan()
        centralManager.connect(heartRatePeripheral!, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        heartRatePeripheral?.discoverServices([heartRateServiceCBUUID])
    }
}

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                subscribedCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: subscribedCharacteristic!)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case bodySensorLocationCharacteristicCBUUID:
            didRecivePosition?(characteristic.value)
        case heartRateMeasurementCharacteristicCBUUID:
            didReciveNewValue?(characteristic.value)
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
}

extension BluetoothManager: BluetoothManagerProtocol {
    func startListening() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func pause() {
        if subscribedCharacteristic != nil {
            heartRatePeripheral?.setNotifyValue(false, for: subscribedCharacteristic!)
        }
    }

    func resume() {
        if subscribedCharacteristic != nil {
            heartRatePeripheral?.setNotifyValue(true, for: subscribedCharacteristic!)
        }
    }

    func stopListening() {
        if let heartRatePeripheral = heartRatePeripheral {
            centralManager.cancelPeripheralConnection(heartRatePeripheral)
        }
    }
}
