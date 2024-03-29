//
//  CardView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/21/23.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
              // here becomes a problem when we want to localize because the text is rendered but there is no text after so the system determines it's a number. In localizable file use %lld to reprsent Int with no text 
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("number of attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .labelStyle(.trailingIcon)
                    .accessibilityLabel("length of the meeting")

            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleData[0]
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}


