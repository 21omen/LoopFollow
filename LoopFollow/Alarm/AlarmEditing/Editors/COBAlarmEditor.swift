// LoopFollow
// COBAlarmEditor.swift
// Created by Jonas Björkert on 2025-05-15.

import SwiftUI

struct COBAlarmEditor: View {
    @Binding var alarm: Alarm

    var body: some View {
        Form {
            InfoBanner(
                text: "Alerts when Carbs-on-Board exceeds the amount you set below.",
                alarmType: alarm.type
            )

            AlarmGeneralSection(alarm: $alarm)

            AlarmStepperSection(
                header: "Threshold",
                footer: "Alert when COB ≥ this many grams.",
                title: "COB",
                range: 1 ... 200,
                step: 1,
                unitLabel: "g",
                value: Binding(
                    get: { alarm.threshold ?? 20 },
                    set: { alarm.threshold = $0 }
                )
            )

            AlarmActiveSection(alarm: $alarm)
            AlarmAudioSection(alarm: $alarm)

            AlarmSnoozeSection(
                alarm: $alarm,
                range: 1 ... 6,
                step: 1
            )
        }
        .navigationTitle(alarm.type.rawValue)
    }
}
