//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/22/23.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    private var  totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else {return 1}
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        guard secondsRemaining > 0 else {return 1}
        return secondsRemaining / 60
        
    }
  
    let secondsEl = String(localized: "Seconds Elapsed")
    let secondsRemain = String(localized: "Seconds Remaining")
    let timeRemain = String(localized: "Time Remaining")
    let min = String(localized: "minutes")
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(secondsEl)")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(secondsRemain)")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(timeRemain)
        .accessibilityValue("\(minutesRemaining) \(min)")
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}
