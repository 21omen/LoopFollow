// LoopFollow
// Observable.swift
// Created by Jonas Björkert on 2024-07-28.

import Foundation
import HealthKit
import SwiftUI

/*
 Observable in memory storage
 */

class Observable {
    static let shared = Observable()

    var tempTarget = ObservableValue<HKQuantity?>(default: nil)
    var override = ObservableValue<String?>(default: nil)

    var minAgoText = ObservableValue<String>(default: "?? min ago")
    var bgText = ObservableValue<String>(default: "BG")
    var bgStale = ObservableValue<Bool>(default: true)
    var bgTextColor = ObservableValue<Color>(default: .yellow)
    var directionText = ObservableValue<String>(default: "-")
    var deltaText = ObservableValue<String>(default: "+0")

    var currentAlarm = ObservableValue<UUID?>(default: nil)

    var debug = ObservableValue<Bool>(default: false)

    private init() {}
}
