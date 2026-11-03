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
    var longBreakDuration: TimeInterval = 30 * 60 
    var snoozeDuration: TimeInterval = 5 * 60 // real: 5 * 60 // testing: 5
    
    
    var numOfWorkToLongBreak: Int = 4 // work sessions before longBreak
     
    var breakReadyDuration: TimeInterval = 5 // time to see notification and click 'snooze'
    var maxSnoozeCount: Int = 2
    
    var snoozeEnabled: Bool = true
    var longBreakEnabled: Bool = true
}

// TODO: sound level setting
// LATER TODO: different sound selections

