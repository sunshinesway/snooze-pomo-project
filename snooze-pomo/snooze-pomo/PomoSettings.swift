//
//  PomoSettings.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//
import Foundation

// MODEL
struct PomoSettings  {
    
    // Configured durations, preferences
    var workDuration: TimeInterval =  15 // real: 60 * 60
    var breakDuration: TimeInterval =  5 // real: 10 * 60
    var snoozeDuration: TimeInterval = 5 // real: 5 * 60
    
    var breakReadyDuration: TimeInterval = 5 // time to see notification and click 'snooze'
    var maxSnoozeCount: Int = 2
    
    mutating func setWorkDuration(_ duration: TimeInterval) {
        workDuration = duration
    }
    mutating func setBreakDuration(_ duration: TimeInterval) {
        breakDuration = duration
    }
    mutating func snoozeDuration(_ duration: TimeInterval) {
        snoozeDuration = duration
    }
    mutating func setBreakReadyDuration(_ duration: TimeInterval) {
        breakReadyDuration = duration
    }
    mutating func setMaxSnoozeCount(_ count: Int) {
        maxSnoozeCount = count
    }
}
