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
    
//    @State private var timerRunning: Bool = false
        
    var body: some View {
        
        VStack {
            
            switch engine.phase {
                case .idle:
                    Button("Start Work"){
                        engine.start()
                    }
                case .working, .onBreak:
                    VStack {
                        if engine.phase == .working {
                            Text("Working")
                        }
                        else { Text("On Break") }
                        
                        Text(engine.timeRemainingString)
                            .font(Font.system(size: 48))
                        HStack {
                            Button("Stop"){
                                engine.stop()
                            }
                            Button("Pause"){
                                engine.pause()
                            }
                        }.padding()
                    }
                
                case .snoozed:
                    VStack {
                        Text("Snoozed Break")
                        
                        Text(engine.timeRemainingString)
                            .font(Font.system(size: 48))
                        HStack {
                            Button("Stop"){
                                engine.stop()
                            }
                            Button("Skip"){ // end snooze - go to break
                                engine.skip()
                            }
                        }.padding()
                    }
                
                case .breakReady:
                    
                
                    
            }
        }
    }
    .padding()
}


#Preview {
    ContentView()
}

