//
//  PomoEngine.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import Foundation
import Combine
import UserNotifications

// phases of the pomodoro timer
enum PomoPhase: Equatable {
    case idle       // not working
    case working    // work session
//    case breakReady // when break can be snoozed
//    case snoozed    // postponed break
    case onBreak    // break session
}

final class PomoEngine: ObservableObject {
    public init() {}
    
    // Configured durations, preferences
    @Published var workDuration: TimeInterval = 60 * 60
    @Published var breakDuration: TimeInterval = 10 * 60
//    @Published var snoozeDuration: TimeInterval = 5 * 60
    
//    @Published var maxSnoozeCount: Int = 2
    
    // Live state
    @Published var phase: PomoPhase = .idle
    @Published var timeRemaining: TimeInterval = 0
    @Published var isPaused: Bool = false
//    @Published var isSnoozed: Bool = false
    
    
    // Time Remaining Display
    var timeRemainingString: String {
        var timeRem = Int(max(0, timeRemaining))
        var mins = timeRem / 60
        var secs = timeRem % 60
        return String(format: "%d:%02d", mins, secs)
    }
    
    // Internal timing
    private var endDate: Date?
    private var ticker: Timer?
    
    private func beginCountdown() {
        
    }
    
    private func Tick() {
        
    }
    
    private func handlePhaseChange() {
        
    }
    
    // Controls
    func startWork() {
        
    }
    
    func startBreak() {
        
    }
    
//    func snoozeBreak() {}
    
    func stop() {
        
    }
    
    // Notifications
    func notify() {
        
    }
}
