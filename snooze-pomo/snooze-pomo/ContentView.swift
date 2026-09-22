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
    @Environment(\.appearsActive) private var appearsActive
    @Environment(\.openWindow) private var openWindow
        
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
                            Button("Skip"){
                                engine.skip()
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
                    VStack() {
                        Text("Snooze break?")
                        Button("Snooze"){
                            engine.snooze()
                        }
                    }
                    
            }
        }
        .padding()
        .onChange(of: engine.phase) {_, newPhase in
            if newPhase == .breakReady && !appearsActive{
                openWindow(id: "snooze-prompt")
            }
        }
    }
    
}


#Preview {
    ContentView()
}

