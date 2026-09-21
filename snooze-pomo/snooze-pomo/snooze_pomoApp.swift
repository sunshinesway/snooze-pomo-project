//
//  snooze_pomoApp.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import SwiftUI

@main
struct snooze_pomoApp: App {
    // TODO: add stateobject PomoEngine object
    @StateObject var engine: PomoEngine = PomoEngine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(engine)
        }
     // TODO: add MenuBarExtra for menu bar utility
    
    }
}
