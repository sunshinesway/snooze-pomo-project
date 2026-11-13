//
//  TimerView-iOS.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 11/13/26.
//

import SwiftUI

struct TimerView_iOS: View {
    @EnvironmentObject var engine: PomoEngine
    @State private var showSettings: Bool = false
    
    private var accent: Color {
        switch engine.phase {
            case .idle: return .accentColor
            case .working: return work_red
            case.onBreak: return break_blue
            case .snoozed, .breakReady: return snooze_purple
        }
    }
        
    private var title: String {
        switch engine.phase {
            case .idle: return ""
            case .working: return "Working"
            case.onBreak: return "On Break"
            case .snoozed: return "Snoozed Break"
            case .breakReady: return "Ready for a break?"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(title)
                
                if engine.phase == .snoozed {
                    Text("Snoozed used: \(engine.snoozesUsed)")
                }
                if engine.phase == .breakReady {
                    Text("Break starts in: ")
                }
                
                if engine.phase != .idle {
                    Text(engine.timeRemainingString)
                }
                
                //
                // controls
                //
                timerControls
            }
        }
    }
    @ViewBuilder
    private var timerControls: some View {
        switch engine.phase {
            case .idle:
                Button {
                    engine.start()
                } label: {
                    Text("Start Work")
                }
            case .working, .onBreak:
                HStack{
                    Button {
                        engine.stop()
                    } label: {
                        Label("Stop", systemImage: "stop.fill")
                    }
                    Button {
                        engine.pause()
                    } label: {
                        Label(engine.isPaused ? "Resume" : "Pause",
                              systemImage: engine.isPaused ? "play.fill" : "pause.fill")
                    }
                    Button {
                        engine.skip()
                    } label: {
                        Label("Skip", systemImage: "foward.fill")
                    }
                }
            case .snoozed:
                HStack {
                    Button {
                        engine.stop()
                    } label: {
                        Label("Stop", systemImage: "stop.fill")
                    }
                    Button {
                        engine.skip()
                    } label: {
                        Label("Skip", systemImage: "foward.fill")
                    }
                }
            case .breakReady:
                Button {
                    engine.snooze()
                } label: {
                    Text("Snooze")
                }
        }
    }
}
