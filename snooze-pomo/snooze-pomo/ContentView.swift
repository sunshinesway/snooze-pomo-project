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
    
    private var isPaused: Bool {
        engine.isPaused
    }
    
    let work_red = Color(red: 0.956, green: 0.0, blue: 0.207)
    let break_blue = Color(red: 0.0, green: 0.655, blue: 0.871)
    let snooze_purple = Color(red: 0.847, green: 0.388, blue: 1.0)
    
    
    var body: some View {
        
        VStack {
            
            switch engine.phase {
                case .idle:
                    Button {
                        engine.start()
                    } label: {
                        Text("Start Work")
                            .padding(.horizontal, 8)
                            .frame(height: 44)
                            .cornerRadius(8)
                            .font(Font.system(size: 20))
//                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                case .working, .onBreak:
                    VStack {
                        if engine.phase == .working {
                            Text("Working")
                                .foregroundStyle(work_red)
                                .font(Font.system(size: 20))
                                .bold()
                            
                        }
                        else {
                            Text("On Break")
                                .foregroundStyle(break_blue)
                                .font(Font.system(size: 20))
                                .bold()

                        }
                        Text(engine.timeRemainingString)
                            .font(Font.system(size: 72))
                        // TODO: show number of work sesssions completed, re: long break
                        HStack {
                            Button("Stop"){
                                engine.stop()
                            }
                            Button(action: {
                                engine.pause()
                            }) {
                                Text(isPaused ? "Resume" : "Pause")
                            }
                            Button("Skip"){
                                engine.skip()
                            }
                        }.padding()
//                        Text(String(engine.workSessionsCompleted))
//                        Text("Max: \(engine.settings.numOfWorkToLongBreak)")
                    }
                
                case .snoozed:
                    VStack {
                        Text("Snoozed Break")
                            .foregroundStyle(snooze_purple)
                            .font(Font.system(size: 20))
                            .bold()
                        Text("Snoozes used: \(engine.snoozesUsed)")
                            .font(Font.system(size: 12))
                        Text(engine.timeRemainingString)
                            .font(Font.system(size: 72))
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
                            .font(Font.system(size: 32))
                        Button("Snooze"){
                            engine.snooze()
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.headline.bold())
                        .frame(width: 100, height: 50)
                    }
                    
                    
            }
        }
        .padding()
        .onChange(of: engine.phase) {_, newPhase in
            if newPhase == .breakReady && !appearsActive{
                openWindow(id: "snooze-prompt")
            }
        }
        .frame(width: 300, height: 200)
    }
    
}


#Preview {
    ContentView()
}

