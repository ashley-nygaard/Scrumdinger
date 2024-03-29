//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/22/23.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
  
  let noMore = String(localized: "No more speakers")
  let speaker = String(localized: "Speaker")
  let last = String(localized: "Last Speaker")
  let next = String(localized: "Next Speaker")
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted}) else {return nil}
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy{ $0.isCompleted}
        // speakers.dropLast().reduce(true){$0 && $1.isCompleted}
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return noMore}
        return "\(speaker) \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text( "\(last)")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(next)
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
