//
//  AlarmManager.swift
//  LoopFollow
//
//  Created by Jonas Björkert on 2025-03-15.
//  Copyright © 2025 Jon Fawcett. All rights reserved.
//

import Foundation

class AlarmManager {
    static let shared = AlarmManager()

    private let evaluators: [AlarmType: AlarmCondition]
    private let config: AlarmConfiguration

    private init(
        config: AlarmConfiguration = .default,
        conditionTypes: [AlarmCondition.Type] = [
            BuildExpireCondition.self
            // …add your other condition types here
        ]
    ) {
        self.config = config
        var dict = [AlarmType: AlarmCondition]()
        conditionTypes.forEach { dict[$0.type] = $0.init() }
        evaluators = dict
    }

    //TODO: Somehow we need to silent the current alarm if the current one is no longer active.
    func checkAlarms(data: AlarmData) {
        let now = Date()
        let alarms = Storage.shared.alarms.value

        let sorted = alarms.sorted { lhs, rhs in
            // Primary: type priority
            if lhs.type.priority != rhs.type.priority {
                return lhs.type.priority < rhs.type.priority
            }
            // Secondary: threshold ordering if applicable
            if let asc = lhs.type.thresholdSortAscending {
                let leftVal = lhs.threshold ?? (asc ? Float.infinity : -Float.infinity)
                let rightVal = rhs.threshold ?? (asc ? Float.infinity : -Float.infinity)
                return asc ? leftVal < rightVal : leftVal > rightVal
            }
            // Tertiary: fallback to insertion order
            return false
        }
        var skipType: AlarmType? = nil

        for alarm in sorted {
            // If there is already an active (snoozed) alarm of this type, skip to next [type]
            if alarm.type == skipType {
                continue
            }

            // If the alarm itself is snoozed, skip lower‑priority alarms of the same type.
            if let until = alarm.snoozedUntil, until > now {
                skipType = alarm.type
                continue
            }

            // Evaluate the alarm condition.
            guard let checker = evaluators[alarm.type],
                  checker.shouldFire(alarm: alarm, data: data, now: now, config: config)
            else {
                continue
            }

            // Fire the alarm and break the loop; we only allow one alarm per evaluation tick.

            //TODO: a few things affecting the snoozed screen
            Storage.shared.currentAlarm.value = alarm.id
            //tabBarController?.selectedIndex = 2

            alarm.trigger(config: config, now: now)
            break
        }
    }

    func snoozeCurrentAlarm(by minutes: Int) {
        //guard var alarm = currentAlarm else { return }
        //alarm.snoozedUntil = Date().addingTimeInterval(TimeInterval(minutes * 60))

        // write it back to your Storage
        /*
        Storage.shared.alarms.value = Storage.shared.alarms.value
            .map { $0.id == alarm.id ? alarm : $0 }
*/
        // clear so you can’t snooze twice
        //currentAlarm = nil
    }
}
