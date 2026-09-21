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

struct DisabledButtonExample: View {
  // Track whether the button is disabled
  @State private var isButtonDisabled = true
 
  var body: some View {
    VStack(spacing: 20) {
      // Toggle to control disabled state
      Toggle("Disable Button", isOn: $isButtonDisabled)
        .padding()
 
      // Button with disabled modifier
      Button(action: {
        print("Button was tapped!")
      }) {
        Text("Submit")
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
      // Disable if isButtonDisabled is true
      .disabled(isButtonDisabled)
    }
  }
}
