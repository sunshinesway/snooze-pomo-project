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
    private let settingsStore: SettingsStore
    
    public init(
        settingsStore: SettingsStore = UserDefaultsSettingsStore()
    ) {
        self.settingsStore = settingsStore
        self.settings = settingsStore.load() ?? PomoSettings()
    }
    
    
    @Published var settings: PomoSettings = PomoSettings(
            workDuration: 60 * 60,
            breakDuration: 10 * 60,
            longBreakDuration: 30 * 60,
            snoozeDuration: 5 * 60,
            numOfWorkToLongBreak: 4) {
        didSet { settingsStore.save(settings)}
    }
    private var soundPlayer: SoundPlayer = SoundPlayer()
    
    // Live state
    @Published private(set) var phase: PomoPhase = .idle
    @Published private(set) var timeRemaining: TimeInterval = 0
    @Published private(set) var isPaused: Bool = false
    
    private(set) var snoozesUsed: Int = 0
    private(set) var workSessionsCompleted: Int = 0
    
    // Time Remaining Display
    var timeRemainingString: String {
        let timeRem = Int(max(0, timeRemaining))
        let mins = timeRem / 60
        let secs = timeRem % 60
        return String(format: "%d:%02d", mins, secs)
    }
    
    // Internal timing
    private var ticker: Timer?
    
    private func beginCountdown(duration: TimeInterval, phase newPhase: PomoPhase) {
        ticker?.invalidate() // stop ticker if running
        phase = newPhase
        timeRemaining = duration
        
        let t = Timer(timeInterval: 1.0, repeats: true) {[weak self] _ in
                self?.tick()
        } // one second tick
        
        RunLoop.main.add(t, forMode: .common)
        ticker = t
    }
    
    private func tick() {
        timeRemaining -= 1
        
        if timeRemaining <= 0 {
            handlePhaseChange()
        }
    }
    
    private func handlePhaseChange(snoozing: Bool = false) {
        ticker?.invalidate()
        ticker = nil
        if !snoozing {
            soundPlayer.playSound()
        }
        
        switch phase { // go to next phase
            case .working:
                workSessionsCompleted += 1
                if settings.snoozeEnabled {
                    beginCountdown(duration: settings.breakReadyDuration, phase: .breakReady)
                }
                else {
                    beginCountdown(duration: settings.breakDuration, phase: .onBreak)
                }
//                notify(title: "Work Session complete", body: "Take a break!")
            
            case .onBreak:
                beginCountdown(duration: settings.workDuration, phase: .working)
//                notify(title: "Break complete", body: "Back to work!")
          
            case .snoozed:
                if snoozesUsed < settings.maxSnoozeCount {
                    beginCountdown(duration: settings.breakReadyDuration, phase: .breakReady)
                }
                else {
                    snoozesUsed = 0
                    beginCountdown(duration: settings.breakDuration, phase: .onBreak)
                }
            
            case .breakReady:
                if snoozing {
                    beginCountdown(duration: settings.snoozeDuration, phase: .snoozed)
                    snoozesUsed += 1
                }
                else {
                    if (workSessionsCompleted >= settings.numOfWorkToLongBreak) {
                        beginCountdown(duration: settings.longBreakDuration, phase: .onBreak)
                        workSessionsCompleted = 0
                    } else {
                        beginCountdown(duration: settings.breakDuration, phase: .onBreak)
                    }
            }
                
            case .idle: // should NOT fire from .idle phase: .idle -> .working handled by start()
                break
        }
    }
    
    // Controls
    func start() { // start a new work session
        beginCountdown(duration: settings.workDuration, phase: .working)
    }

    func pause() {
        if ticker != nil { // pause
            ticker?.invalidate()
            ticker = nil
            isPaused = true
        }
        else if (isPaused && timeRemaining > 0){ // unpause
            beginCountdown(duration: timeRemaining, phase: phase)
            isPaused = false
        }
    }
    
    func skip() {
        handlePhaseChange()
        isPaused = false
    }
    
    func snooze() {
        handlePhaseChange(snoozing: true)
    }
        
    func stop() {
        ticker?.invalidate()
        ticker = nil
        timeRemaining = 0
        phase = .idle
        isPaused = false
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
