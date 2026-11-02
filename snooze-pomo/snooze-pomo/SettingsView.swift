//
//  SettingsView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/25/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var engine: PomoEngine
    
    private var isSnoozeOn: Bool {
        (engine.settings.maxSnoozeCount > 0 && engine.settings.snoozeEnabled)
    }
    
    private var numWorkSessionsArray = Array(2...10)
    
    var body: some View {
        Spacer().frame(height:20)
        Grid(alignment: .center, horizontalSpacing: 12, verticalSpacing: 6) {
            GridRow {
                Text("Work length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", value: minutes_conv(\.settings.workDuration), format: .number)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            GridRow {
                Text("Break length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", value: minutes_conv(\.settings.breakDuration), format: .number)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            GridRow {
                Text("Long Break length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", value: minutes_conv(\.settings.longBreakDuration), format: .number)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .disabled(!engine.settings.longBreakEnabled)
            GridRow {
                Text("Long break:")
                Picker("", selection: $engine.settings.numOfWorkToLongBreak) {
                    ForEach(numWorkSessionsArray, id: \.self) { num in
                        Text("After \(num) work sessions")
                    }
                }
            }
            .disabled(!engine.settings.longBreakEnabled)
            Toggle("Enable Long Breaks", isOn: $engine.settings.longBreakEnabled)
                .toggleStyle(.checkbox)
            
            Spacer()
                .frame(height: 12)
            Toggle("Enable Snooze", isOn: $engine.settings.snoozeEnabled)
                .toggleStyle(.checkbox)
            GridRow {
                Text("Snooze length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", value: minutes_conv(\.settings.snoozeDuration), format: .number)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .disabled(!isSnoozeOn)
            GridRow {
                Text("Max snoozes per break:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                TextField("", value: maxSnoozes(\.settings.maxSnoozeCount), format: .number)
                    .frame(width: 100)
                Text("snoozes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .disabled(!isSnoozeOn)
            
        }
        Spacer().frame(height:20)
    }
    
    private func minutes_conv(_ keyPath: ReferenceWritableKeyPath<PomoEngine, TimeInterval>) -> Binding<Int> {
        Binding(
            get: { Int(engine[keyPath: keyPath] / 60) },
            set: { engine[keyPath: keyPath] = TimeInterval(max(1, $0) * 60) } // floor, 1 min
        )
    }
    private var snoozeEnabled: Binding<Bool> {
        Binding(
            get: { engine.settings.maxSnoozeCount > 0 },
            set: { engine.settings.maxSnoozeCount = $0 ? 2 : 0 }
        )
    }
    private func maxSnoozes(_ keyPath: ReferenceWritableKeyPath<PomoEngine, Int>) -> Binding<Int> {
        Binding(
            get: { engine[keyPath: keyPath] },
            set: { engine[keyPath: keyPath] = max(1, $0) } // clamp: no zero or negative values
        )
    }
}
