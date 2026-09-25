//
//  SettingsView.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/25/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var engine: PomoEngine
    
    @State private var workLength: String = ""
    @State private var breakLength: String = ""
    @State private var snoozeLength: String = ""
    @State private var breakReadyLength: String = ""
    @State private var maxSnooze: String = ""
    
    var body: some View {
        var workLengthInt: Int {
            Int(workLength) ?? 25
        }
        var breakLengthInt: Int {
            Int(breakLength) ?? 5
        }
        var snoozeLengthInt: Int {
            Int(snoozeLength) ?? 5
        }
        var breakReadyLengthInt: Int {
            Int(breakReadyLength) ?? 10
        }
        Spacer().frame(height:20)
        Grid(alignment: .center, horizontalSpacing: 12, verticalSpacing: 6) {
            GridRow {
                Text("Work length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", text: $workLength)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            GridRow {
                Text("Break length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", text: $breakLength)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            GridRow {
                Text("Snooze length:")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                TextField("", text: $snoozeLength)
                    .frame(width: 100)
                Text("minutes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
                .frame(height: 12)
            GridRow {
                Text("Max snoozes per break:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.system(size: 14))
                TextField("", text: $maxSnooze)
                    .frame(width: 100)
                Text("snoozes")
                    .font(Font.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        Spacer().frame(height:20)
    }
        
}
