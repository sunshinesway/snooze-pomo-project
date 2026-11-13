//
//  snooze_pomo_mobileApp.swift
//  snooze-pomo-mobile
//
//  Created by Cheyenne C Swasey on 11/4/26.
//

import SwiftUI

@main
struct snooze_pomo_mobileApp: App {
    @StateObject private var engine = PomoEngine()
    
    var body: some Scene {
        WindowGroup {
            TimerView_iOS()
                .environmentObject(engine)
        }
    }
}
