//
//  ContentView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import SwiftUI

// TODO: notification/pop-up w/ button for user to snooze break
    // currently, notifications are lost in notifications panel on macOS
// TODO: add ping noise for swtich between work/break/snooze

// VIEW
struct ContentView: View {
    @EnvironmentObject var engine: PomoEngine
    
    @State private var timerRunning: Bool = false
        
    var body: some View {
        
        VStack {
            Button("Start/Stop"){
                if engine.timeRemaining.isZero {
                    engine.startWork()
                    timerRunning = true
                    
                }
                else {
                    engine.stop()
                    timerRunning = false
                }
}
            Button("Pause",
                   action: { engine.pause() })
            .disabled(timerRunning == false || engine.timeRemaining.isZero)
            Text(engine.timeRemainingString)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

