//
//  PomoSettings.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//
import Foundation

// MODEL
struct PomoSettings: Codable, Equatable  {
    
    // Configured durations, preferences
    var workDuration: TimeInterval =  60 * 60 // real: 60 * 60 // testing: 15
    var breakDuration: TimeInterval =  10 * 60 // real: 10 * 60 // testing: 5
    var snoozeDuration: TimeInterval = 5 * 60 // real: 5 * 60 // testing: 5
    
    var breakReadyDuration: TimeInterval = 5 // time to see notification and click 'snooze'
    var maxSnoozeCount: Int = 2
    
    var snoozeEnabled: Bool = true
    
//    mutating func setWorkDuration(_ duration: TimeInterval) {
//        workDuration = duration
//    }
//    mutating func setBreakDuration(_ duration: TimeInterval) {
//        breakDuration = duration
//    }
//    mutating func setSnoozeDuration(_ duration: TimeInterval) {
//        snoozeDuration = duration
//    }
//    mutating func setBreakReadyDuration(_ duration: TimeInterval) {
//        breakReadyDuration = duration
//    }
//    mutating func setMaxSnoozeCount(_ count: Int) {
//        maxSnoozeCount = count
//    }
}

// TODO: long break addition ( + length of w/b/lb cycle)
// TODO: sound level setting
// LATER TODO: different sound selections

