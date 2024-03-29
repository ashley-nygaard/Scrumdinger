//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/27/23.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let isRecording: Bool
    let theme: Theme
  
  let someone = String(localized: "Someone")
  let isSpeaking = String(localized: "is speaking")
  let onDeck = String(localized: "On Deck")
  let withT = String(localized: "with transcription")
  let withoutT = String(localized: "without transcription")

    
    
    private var currentSpeaker: String {
        speakers.first(where: {!$0.isCompleted})?.name ?? someone
    }
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil}
        return index + 1
    }
    private var speakerText: String {
        speakers[speakerNumber!].name
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack{
                    Text(currentSpeaker)
                        .font(.title)
                    Text(" \(isSpeaking)")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? withT : withoutT)
                    if (speakerNumber != nil && speakerNumber! < speakers.count){
                        Text("\(onDeck)")
                            .padding(.top)
                        Text(speakerText)
                    }
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
               
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)

                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
           [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
       }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, isRecording: true, theme: .yellow)
    }
}
