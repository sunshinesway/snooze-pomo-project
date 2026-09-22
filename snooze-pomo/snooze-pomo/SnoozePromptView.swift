//
//  SnoozePromptView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/22/26.
//

import SwiftUI

struct SnoozePromptView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            Image(systemName: "window")
                .font(Font.system(size: 48))
            Text("Snooze Prompt")
                .font(.title)
            Button("Snooze") {
                dismiss()
            }
        }
    }
}

struct SecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        SnoozePromptView()
    }
}
