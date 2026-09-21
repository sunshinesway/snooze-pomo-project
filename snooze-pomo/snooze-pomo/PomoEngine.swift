//
//  PomoEngine.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

import Foundation
import Combine
import UserNotifications


// TODO: split PomoEngine to be more in line with MVVM:
// (solve pause question first, may req significant changes)
    // timer logic -> move to service
    // engine -> owns instance of timer, exposes @Pub vars, and intents (startWork/Break, etc)


// VIEW MODEL
final class PomoEngine: ObservableObject {
//    public init() {}
    
    @Published var settings: PomoSettings = PomoSettings(workDuration: 15, breakDuration: 5) // testing vals: 15/5 secs
    
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
//    private var endDate: Date?
    private var ticker: Timer?
    
    private func beginCountdown(duration: TimeInterval, phase newPhase: PomoPhase) {
        ticker?.invalidate() // stop ticker if running
        phase = newPhase
//        endDate = Date().addingTimeInterval(duration)
        timeRemaining = duration
        
        let t = Timer(timeInterval: 1.0, repeats: true) {[weak self] _ in
                self?.tick()
        } // one second tick
        
        RunLoop.main.add(t, forMode: .common)
        ticker = t
    }
    
    private func tick() {
//        guard let endDate else { return }
        timeRemaining -= 1
//        timeRemaining = max(0, endDate.timeIntervalSinceNow)
        
        if timeRemaining <= 0 {
            handlePhaseChange()
        }
    }
    
    private func handlePhaseChange() {
        ticker?.invalidate()
        ticker = nil
        
        switch phase { // go to next phase
            case .working:
            beginCountdown(duration: settings.breakDuration, phase: .onBreak)
            notify(title: "Work Session complete", body: "Take a break!")
            
            case .onBreak:
            beginCountdown(duration: settings.workDuration, phase: .working)
                notify(title: "Break complete", body: "Back to work!")
            
//            case .snoozed:
            
//            case .breakReady:
            
            case .idle: // should NOT fire from .idle phase
                break
        }
    }
    
    // Controls
    func startWork() {
        beginCountdown(duration: settings.workDuration, phase: .working)
    }
    
    func startBreak() {
        beginCountdown(duration: settings.breakDuration, phase: .onBreak)
    }
    func pause() {
        if ticker != nil { // pause
            ticker?.invalidate()
            ticker = nil
            isPaused = true
        }
        else if (timeRemaining > 0){ // unpause
            beginCountdown(duration: timeRemaining, phase: phase)
        }
    }
    
//    func snoozeBreak() {}
    
    func stop() {
        ticker?.invalidate()
        ticker = nil
//        endDate = nil
        timeRemaining = 0
        phase = .idle
    }
    
    // Notifications
    func notify(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // immediately
        )
        UNUserNotificationCenter.current().add(request)
    }
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }
}
