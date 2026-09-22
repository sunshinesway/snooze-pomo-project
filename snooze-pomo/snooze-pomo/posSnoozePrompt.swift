//
//  positionSnoozeWindow.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/22/26.
//

import AppKit
import SwiftUI

func positionSnoozeWindow(window: NSWindow) {
    guard let screen = NSScreen.main else { return }
    
    let visibleFrame = screen.visibleFrame // excl menu bar/dock, usable area only
    let windowFrame = window.frame
    let margin = CGFloat(6)
    
    let x = visibleFrame.maxX - windowFrame.width - margin
    let y = visibleFrame.maxY - windowFrame.height - margin
    
    window.setFrameOrigin(NSPoint(x: x, y: y))
}

struct WindowAccessor: NSViewRepresentable {
    let onResolve: (NSWindow) -> Void
    
    func makeNSView(context: Context) -> some NSView {
        let view = NSView()
        
        DispatchQueue.main.async {
            if let window = view.window {
                onResolve(window)
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
//        DispatchQueue.main.async {
//            if let window = nsView.window {
//                onResolve(window)
//            }
//        }
    }
    
}
