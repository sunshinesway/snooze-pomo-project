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
    
}
