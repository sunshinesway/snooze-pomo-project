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
    @Published private(set) var phase: PomoPhase = .idle
    @Published private(set) var timeRemaining: TimeInterval = 0
    @Published private(set) var isPaused: Bool = false
//    @Published var isSnoozed: Bool = false
    
    
    // Time Remaining Display
    var timeRemainingString: String {
        let timeRem = Int(max(0, timeRemaining))
        let mins = timeRem / 60
        let secs = timeRem % 60
        return String(format: "%d:%02d", mins, secs)
    }
    
    // Internal timing
    private var endDate: Date?
    private var ticker: Timer?
    
    private func beginCountdown(duration: TimeInterval, phase newPhase: PomoPhase) {
        ticker?.invalidate() // stop ticker if running
        phase = newPhase
        endDate = Date().addingTimeInterval(duration)
        timeRemaining = duration
        
        let t = Timer(timeInterval: 1.0, repeats: true) {[weak self] _ in
                self?.tick()
        } // one second tick
        
        RunLoop.main.add(t, forMode: .common)
        ticker = t
    }
    
    private func tick() {
        guard let endDate else { return }
        
        timeRemaining = max(0, endDate.timeIntervalSinceNow)
        
        if timeRemaining <= 0 {
            handlePhaseChange()
        }
    }
    
    private func handlePhaseChange() {
        ticker?.invalidate()
        ticker = nil
        
        switch phase { // go to next phase
            case .working:
                beginCountdown(duration: breakDuration, phase: .onBreak)
                notify(title: "Work Session complete", content: "Break starting!")
            
            case .onBreak:
                beginCountdown(duration: workDuration, phase: .working)
                notify(title: "Break complete", content: "Work session starting!")
            
//            case .snoozed:
//            case .breakReady:
            
            case .idle: // should NOT fire from .idle phase
                break
        }
    }
    
    // Controls
    // Update/use when snooze implemented
    func startWork() {
        
    }
    
    func startBreak() {
        
    }
    
//    func snoozeBreak() {}
    
    func stop() {
        
    }
    
    // Notifications
    func notify(title: String, content: String) {
        
    }
}
