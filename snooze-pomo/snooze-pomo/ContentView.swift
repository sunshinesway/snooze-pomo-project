//
//  ContentView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import SwiftUI

// VIEW
struct ContentView: View {
    @EnvironmentObject var engine: PomoEngine
    
    var body: some View {
        VStack {
            Button("Start/Stop",
                   action: { engine.timeRemaining.isZero ? engine.startWork() : engine.stop() })
            Text(engine.timeRemainingString)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
