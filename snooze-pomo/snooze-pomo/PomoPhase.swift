//
//  PomoPhase.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/21/26.
//

// MODEL
// phases of the pomodoro timer
enum PomoPhase: Equatable {
    case idle       // not working
    case working    // work session
//    case breakReady // when break can be snoozed
//    case snoozed    // postponed break
    case onBreak    // break session
}

