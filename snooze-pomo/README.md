# Snooze Pomo

A native macOS pomodoro timer app built in Swift. The timer allows you to hit 'snooze' on your breaks,
so that you can wrap up a task or take notes on your work and then more fully disconnect while on break.



## Features

- Pomodoro focus and break timers
- Snooze breaks: option to hit 'snooze' on your break to work for a few more minutes to get to a good stopping point.
- Timer shows in the menu bar.
- Snooze notification window pops up if timer is not the active window when work session ends.
- Chime plays when work, break, or snooze completes.
- Can configure work session duration, break durations, long break option, and the snooze functionality, including how many snoozes are allowed before forcing a break.

## Why I built this

I much prefer a pomodoro timer that requires little intervention from me, but I found that I often would be in the middle of work, and not at a good stopping point, so I would often work through my breaks, or pause the break, to continue working - then completely forget to unpause and take the break, disrupting the pomodoro flow entirely.

So I developed this app for my own use - so that I can very easily snooze my break to finish up my work, without running the risk of getting lost in the work and forgetting to take a break.

## Tech stack

- Swift 5
- SwiftUI
- Combine, UserDefaults, AVFAudio
- Xcode 16.0

## Requirements

- macOS 15.8
- Xcode 16.0 to build from source

## Getting started

```bash
git clone https://github.com/sunshinesway/snooze-pomo-project.git
cd snooze-pomo-project
open snooze-pomo/snooze-pomo.xcodeproj   # [FILL IN: confirm the project path]
```

Select the app target, then press **Run** (Cmd+R).

To create an easily runnable application of the project, follow [these steps.](https://developer.apple.com/tutorials/develop-in-swift/test-your-beta-app)

## Project structure

```
snooze-pomo/
  Assets.xcassets
  BarMenu.swift
  ContentView.swift
  PomoEngine.swift
  PomoPhase.swift
  PomoSettings.swift
  posSnoozePrompt.swift
  SettingsView.swift
  snooze-pomoApp.swift
  SnoozePromptView.swift
  SoundPlayer.swift
  StoreSettings.swift
```

## Upcoming
- more sound options
- Add/remove time from work and breaks mid-session
- mobile (iOS) version
- Any user feedback is welcome!

## License

MIT
