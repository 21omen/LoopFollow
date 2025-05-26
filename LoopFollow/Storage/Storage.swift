// LoopFollow
// Storage.swift
// Created by Jonas Björkert on 2024-09-17.

import Foundation
import HealthKit
import UIKit

/*
 Observable persistant storage
 */

class Storage {
    var remoteType = StorageValue<RemoteType>(key: "remoteType", defaultValue: .nightscout)
    var deviceToken = StorageValue<String>(key: "deviceToken", defaultValue: "")
    var expirationDate = StorageValue<Date?>(key: "expirationDate", defaultValue: nil)
    var sharedSecret = StorageValue<String>(key: "sharedSecret", defaultValue: "")
    var productionEnvironment = StorageValue<Bool>(key: "productionEnvironment", defaultValue: true)
    var apnsKey = StorageValue<String>(key: "apnsKey", defaultValue: "")
    var teamId = StorageValue<String?>(key: "teamId", defaultValue: nil)
    var keyId = StorageValue<String>(key: "keyId", defaultValue: "")
    var bundleId = StorageValue<String>(key: "bundleId", defaultValue: "")
    var user = StorageValue<String>(key: "user", defaultValue: "")

    var maxBolus = SecureStorageValue<HKQuantity>(key: "maxBolus", defaultValue: HKQuantity(unit: .internationalUnit(), doubleValue: 1.0))
    var maxCarbs = SecureStorageValue<HKQuantity>(key: "maxCarbs", defaultValue: HKQuantity(unit: .gram(), doubleValue: 30.0))
    var maxProtein = SecureStorageValue<HKQuantity>(key: "maxProtein", defaultValue: HKQuantity(unit: .gram(), doubleValue: 30.0))
    var maxFat = SecureStorageValue<HKQuantity>(key: "maxFat", defaultValue: HKQuantity(unit: .gram(), doubleValue: 30.0))

    var mealWithBolus = StorageValue<Bool>(key: "mealWithBolus", defaultValue: false)
    var mealWithFatProtein = StorageValue<Bool>(key: "mealWithFatProtein", defaultValue: false)

    var cachedJWT = StorageValue<String?>(key: "cachedJWT", defaultValue: nil)
    var jwtExpirationDate = StorageValue<Date?>(key: "jwtExpirationDate", defaultValue: nil)

    var backgroundRefreshType = StorageValue<BackgroundRefreshType>(key: "backgroundRefreshType", defaultValue: .silentTune)

    var selectedBLEDevice = StorageValue<BLEDevice?>(key: "selectedBLEDevice", defaultValue: nil)

    var debugLogLevel = StorageValue<Bool>(key: "debugLogLevel", defaultValue: false)

    var contactTrend = StorageValue<ContactIncludeOption>(key: "contactTrend", defaultValue: .off)
    var contactDelta = StorageValue<ContactIncludeOption>(key: "contactDelta", defaultValue: .off)
    var contactEnabled = StorageValue<Bool>(key: "contactEnabled", defaultValue: false)
    var contactBackgroundColor = StorageValue<String>(key: "contactBackgroundColor", defaultValue: ContactColorOption.black.rawValue)
    var contactTextColor = StorageValue<String>(key: "contactTextColor", defaultValue: ContactColorOption.white.rawValue)

    var sensorScheduleOffset = StorageValue<Double?>(key: "sensorScheduleOffset", defaultValue: nil)

    var alarms = StorageValue<[Alarm]>(key: "alarms", defaultValue: [])
    var alarmConfiguration = StorageValue<AlarmConfiguration>(key: "alarmConfiguration", defaultValue: .default)

    var lastOverrideStartNotified = StorageValue<TimeInterval?>(key: "lastOverrideStartNotified", defaultValue: nil)
    var lastOverrideEndNotified = StorageValue<TimeInterval?>(key: "lastOverrideEndNotified", defaultValue: nil)
    var lastTempTargetStartNotified = StorageValue<TimeInterval?>(key: "lastTempTargetStartNotified", defaultValue: nil)
    var lastTempTargetEndNotified = StorageValue<TimeInterval?>(key: "lastTempTargetEndNotified", defaultValue: nil)
    var lastRecBolusNotified = StorageValue<Double?>(key: "lastRecBolusNotified", defaultValue: nil)
    var lastCOBNotified = StorageValue<Double?>(key: "lastCOBNotified", defaultValue: nil)
    var lastMissedBolusNotified = StorageValue<Date?>(key: "lastMissedBolusNotified", defaultValue: nil)

    // General Settings [BEGIN]
    var appBadge = StorageValue<Bool>(key: "appBadge", defaultValue: true)
    var colorBGText = StorageValue<Bool>(key: "colorBGText", defaultValue: true)
    var forceDarkMode = StorageValue<Bool>(key: "forceDarkMode", defaultValue: true)
    var showStats = StorageValue<Bool>(key: "showStats", defaultValue: true)
    var useIFCC = StorageValue<Bool>(key: "useIFCC", defaultValue: false)
    var showSmallGraph = StorageValue<Bool>(key: "showSmallGraph", defaultValue: true)
    var screenlockSwitchState = StorageValue<Bool>(key: "screenlockSwitchState", defaultValue: true)
    var showDisplayName = StorageValue<Bool>(key: "showDisplayName", defaultValue: false)
    var snoozerEmoji = StorageValue<Bool>(key: "snoozerEmoji", defaultValue: false)

    var speakBG = StorageValue<Bool>(key: "speakBG", defaultValue: false)
    var speakBGAlways = StorageValue<Bool>(key: "speakBGAlways", defaultValue: true)
    var speakLowBG = StorageValue<Bool>(key: "speakLowBG", defaultValue: false)
    var speakProactiveLowBG = StorageValue<Bool>(key: "speakProactiveLowBG", defaultValue: false)
    var speakFastDropDelta = StorageValue<Double>(key: "speakFastDropDelta", defaultValue: 10.0)
    var speakLowBGLimit = StorageValue<Double>(key: "speakLowBGLimit", defaultValue: 72.0)
    var speakHighBGLimit = StorageValue<Double>(key: "speakHighBGLimit", defaultValue: 180.0)
    var speakHighBG = StorageValue<Bool>(key: "speakHighBG", defaultValue: false)
    var speakLanguage = StorageValue<String>(key: "speakLanguage", defaultValue: "en")

    // General Settings [END]

    static let shared = Storage()
    private init() {}
}
