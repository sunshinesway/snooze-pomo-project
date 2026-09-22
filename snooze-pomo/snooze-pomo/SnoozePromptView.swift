//
//  SnoozePromptView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/22/26.
//

import SwiftUI

struct SnoozePromptView: View {
    @EnvironmentObject var engine: PomoEngine
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
                Text("Ready for a break?")
                    .font(.title)
            Button("Snooze", systemImage: "moon.zzz") {
                    engine.snooze()
                }
            .buttonStyle(.borderedProminent)
            .font(.headline.bold())
            .frame(width: 100, height: 50)
           
        }
        .onChange(of: engine.phase) {_, newPhase in
            if newPhase != .breakReady {
                dismiss()
            }
        }
        .frame(width: 250, height: 150)
        .background {
            WindowAccessor { window in
                positionSnoozeWindow(window: window)}
        }
    }
}
