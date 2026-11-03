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
    
//  // helpers
    
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
    
    
//  // basic functionality
    @Test func startWorkSession() {
        engine.start()
        
        #expect(engine.phase == .working)
        #expect(engine.timeRemaining == 60)
    }
    
    @Test func tickCountsDown() {
        engine.start()
        tick(10)
        
        #expect(engine.timeRemaining == 50) // 60 - 10 = 50
    }
    
    @Test func stopReturnsToIdle() {
        engine.start()
        tick(3)
        engine.stop()
        
        #expect(engine.phase == .idle)
        #expect(engine.timeRemaining == 0)
    }
    
    // timeRemainingString accuracy
    @Test(arguments: [(5, "0:05"), (59, "0:59"), (60,"1:00"), (125,"2:05"), (3600,"60:00")])
    func timeRemainingStringFormat(sec: Int, expected: String) {
        engine.settings.workDuration = TimeInterval(sec)
        engine.start()
        
        #expect(engine.timeRemainingString == expected)
    }
    
//  // phase transitions
    @Test func workEnd_SnoozeEnabled_transBreakReady() {
        reachBreakReady()
        
        #expect(engine.phase == .breakReady)
        #expect(engine.timeRemaining == 5)
    }
    
    @Test func workEnd_SnoozeDisabled_transBreak() {
        engine.settings.snoozeEnabled = false
        engine.start()
        finishPhase()
        
        #expect(engine.phase == .onBreak)
        #expect(engine.timeRemaining == 15)
    }
    
    @Test func breakReadyExpire_woSnooze_transBreak() {
        reachBreakReady()
        finishPhase()
        
        #expect(engine.phase == .onBreak)
        #expect(engine.timeRemaining == 15)
    }
    
    @Test func breakEnd_transWork() {
        reachBreakReady()
        finishPhase() // breakReady -> onBreak
        finishPhase() // onBreak -> working
        
        #expect(engine.phase == .working)
        #expect(engine.timeRemaining == 60)
    }
    
//  // snooze functionality
    @Test func snooze_BreakReady_startCountdown() {
        reachBreakReady()
        engine.snooze()
        
        #expect(engine.phase == .snoozed)
        #expect(engine.timeRemaining == 10)
        #expect(engine.snoozesUsed == 1)
    }
    
    @Test func snoozeExpire_returnToBreakReady_SnoozesRemaining() {
        reachBreakReady()
        engine.snooze()
        finishPhase()
        
        #expect(engine.phase == .breakReady)
    }
    
    @Test func noSnoozesLeft_forceBreak() {
        engine.settings.maxSnoozeCount = 2
        reachBreakReady()
        
        engine.snooze() // 1st snooze
        finishPhase()
        engine.snooze() // 2nd snooze, cap reached
        finishPhase()
        
        #expect(engine.phase == .onBreak)
    }
    
    @Test func snoozeCount_Reset_PerBreak(){
        reachBreakReady()
        engine.snooze()
        finishPhase() // back to breakReady w/ 1 snooze used
        finishPhase() // breakReady -> onBreak
        
        #expect(engine.snoozesUsed == 0)
    }
    
//  // long break functionality
    @Test func longBreak_after_SpecNumWorks() {
        engine.settings.longBreakEnabled = true
        engine.settings.numOfWorkToLongBreak = 2
        
        engine.start()
        finishPhase() // work #1 -> breakReady
        finishPhase() // short break
        #expect(engine.timeRemaining == 15)
        
        finishPhase() // shortBreak -> work #2
        finishPhase() // work #2 -> breakReady
        finishPhase() // long break
        
        #expect(engine.phase == .onBreak)
        #expect(engine.timeRemaining == 30)
    }
    
    @Test func longBreak_Happens_WhenSnoozeDisabled() {
        engine.settings.snoozeEnabled = false
        engine.settings.longBreakEnabled = true
        engine.settings.numOfWorkToLongBreak = 1
        
        engine.start() // work #1 -> breakReady
        finishPhase() // breakReady -> long break
        
        #expect(engine.timeRemaining == 30)
    }
    
    @Test func longBreak_Happens_When_SnoozesRunOut() {
        engine.settings.longBreakEnabled = true
        engine.settings.numOfWorkToLongBreak = 2
        engine.settings.maxSnoozeCount = 1
        
        reachBreakReady() // work #1 -> breakReady
        engine.snooze() // use snooze, cap reached
        finishPhase() // -> force long break
        
        #expect(engine.phase == .onBreak)
        #expect(engine.timeRemaining == 30)
    }
    
//  // pause functionality
    @Test func pause_StopsCountdown() {
        engine.start()
        tick(10)
        engine.pause()
        
        #expect(engine.isPaused)
        #expect(engine.timeRemaining == 50) // 60 - 10 = 50
    }
    
    @Test func pauseTwice_resumesWhereItLeftOff() {
        engine.start()
        tick(10)
        engine.pause() // timeRem = 50
        engine.pause() // resume
        
        #expect(!engine.isPaused)
        #expect(engine.phase == .working)
        #expect(engine.timeRemaining == 50)
    }
    
}
