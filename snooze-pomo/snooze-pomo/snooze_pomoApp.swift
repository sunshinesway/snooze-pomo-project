//
//  snooze_pomoApp.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import SwiftUI

@main
struct snooze_pomoApp: App {
    @StateObject var engine: PomoEngine = PomoEngine()
    
//    init() {
//        // this must run once; store the viewModel instance is fine to call on too
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(engine)
//                .onAppear {
//                    engine.requestPermission()
//                }
        }
        Window("Snooze Break?", id: "snooze-prompt") {
            SnoozePromptView()
                .environmentObject(engine)
        }
        .windowLevel(.floating)
        MenuBarExtra(
            engine.timeRemainingString
        ) {
            BarMenu()
                .environmentObject(engine)
        }
        .menuBarExtraStyle(.menu)
        #if os(macOS)
        Settings {
            SettingsView()
                .environmentObject(engine)
                .windowResizeBehavior(.disabled)
                .frame(width: 500, height: 300)
        }
        #endif
            
     // TODO: add MenuBarExtra for menu bar utility
    
    }
}
        
