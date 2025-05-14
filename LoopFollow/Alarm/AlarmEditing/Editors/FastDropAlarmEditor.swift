//
//  FastDropAlarmEditor.swift
//  LoopFollow
//
//  Created by Jonas Björkert on 2025-05-10.
//  Copyright © 2025 Jon Fawcett. All rights reserved.
//

import SwiftUI

struct FastDropAlarmEditor: View {
    @Binding var alarm: Alarm

    @State private var useLimit: Bool = false

    var body: some View {
        Form {
            InfoBanner(
                text: "Alerts when glucose readings drop rapidly. For example, three straight readings each falling by at least the amount you set. Optionally limit alerts to only fire below a certain BG level."
            )
            AlarmGeneralSection(alarm: $alarm)

            AlarmBGSection(
                header: "Rate of Fall",
                footer: "How much the bg must fall to count as a “fast” drop.",
                title: "Drop per reading",
                range: 3...20,
                value: Binding(
                    get: { alarm.delta ?? 18 },
                    set: { alarm.delta = $0 }
                )
            )

            //TODO: In the migration script, use 1 value less than stored since we are switching from readings to drops
            AlarmStepperSection(
                header: "Consecutive Drops",
                footer: "Number of back-to-back drops—each meeting the rate above—required before an alert fires.",
                title: "Drops in a row",
                range: 1...3,
                step: 1,
                value: Binding(
                    get: { Double(alarm.monitoringWindow ?? 2) },
                    set: { alarm.monitoringWindow = Int($0) }
                )
            )

            AlarmBGLimitSection(
                header: "BG Limit",
                footer: "When enabled, this alert only fires if the glucose is below the limit you set.",
                toggleText: "Use BG Limit",
                pickerTitle: "Dropping below",
                range: 40...300,
                value: $alarm.threshold
            )

            AlarmAudioSection(alarm: $alarm)

            AlarmActiveSection(alarm: $alarm)

            AlarmSnoozeSection(
                alarm: $alarm,
                range: 5...60,
                step: 5
            )
        }
        .navigationTitle(alarm.type.rawValue)
    }
}
