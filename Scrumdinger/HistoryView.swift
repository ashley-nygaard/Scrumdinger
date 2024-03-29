//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/27/23.
//

import SwiftUI

struct HistoryView: View {
  
    let attendees = String(localized: "Attendees")
    let transcript = String(localized: "Transcript")
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("\(attendees)")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("\(transcript)")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}
extension History {
    // displays attendees in human readable form
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [DailyScrum.Attendee(name: "Jon"), DailyScrum.Attendee(name: "Darla"), DailyScrum.Attendee(name: "Luis")], lengthInMinutes: 10, transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    static var previews: some View {
        HistoryView(history: history)
    }
}
