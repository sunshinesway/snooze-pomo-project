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
                
            }
        }
    }
}
