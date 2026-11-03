//
//  PomoEngineTests.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 11/3/26.
//

import Foundation
import Testing

@testable import snooze_pomo

// test doubles

// tests do not touch real UserDefaults
final class InMemSettingsStore: SettingsStore {
    var saved: PomoSettings?
    func load() -> PomoSettings? { saved }
    func save(_ settings: PomoSettings) { saved = settings }
}

// count CHIMES so that sound does not play every test
final class TestSoundPlayer: SoundPlaying {
    private(set) var playCount = 0
    func playSound() { playCount += 1 }
}

struct PomoEngineTests {
    let store = InMemSettingsStore()
    let sound = TestSoundPlayer()
    let engine: PomoEngine
    
    init() {
        engine = PomoEngine(settingsStore: store, soundPlayer: sound)
        
        // small, distinct durations for testing
        engine.settings.workDuration = 60
        engine.settings.breakDuration = 15
        engine.settings.longBreakDuration = 30
        engine.settings.snoozeDuration = 10
        engine.settings.breakReadyDuration = 5
        engine.settings.maxSnoozeCount = 2
        engine.settings.snoozeEnabled = true
        engine.settings.longBreakEnabled = false
    }
    
    // helpers
    
    // sim "seconds" w/ no real waiting
    private func tick(_ seconds: Int) {
        for _ in 0..<seconds { engine.tick() }
    }
    
    // let current phase run out
    private func finishPhase() {
        tick(Int(engine.timeRemaining))
    }
    
    private func reachBreakReady() {
        engine.start()
        finishPhase()
    }
    
    
    
}
