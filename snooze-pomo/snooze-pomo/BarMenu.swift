//
//  BarMenu.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/25/26.
//

import SwiftUI

struct BarMenu: View {
    @EnvironmentObject var engine: PomoEngine
    
    var body: some View {
        VStack {
//            Button("1", action: { print_option(num: 1) })
//            Button("2", action: { print_option(num: 2) })
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
 
                        Button("Stop"){
                            engine.stop()
                        }
                        Button("Pause"){
                            engine.pause()
                        }
                        Button("Skip"){
                            engine.skip()
                        }

                    }
                
                case .snoozed:
                    VStack {
                        Text("Snoozed Break")

                            Button("Stop"){
                                engine.stop()
                            }
                            Button("Skip"){ // end snooze - go to break
                                engine.skip()
                            }
                    }
                default:
                    Button("Stop"){
                        engine.stop()
                    }
            }
            
        }
    }
}
