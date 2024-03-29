/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    let info = String(localized: "Meeting Info")
    let title = String(localized: "Title")
    let length = String(localized: "Length")
    let minutes = String(localized: "minutes")
    let attendees = String(localized: "attendees")
    let newAttendee = String(localized: "New Attendee")
    let addAttendee = String(localized: "Add Attendee")
        
    var body: some View {
        Form {
            Section(header: Text("\(info)")) {
                TextField("\(title)", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("\(length)")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) \(minutes)")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) \(minutes)")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("\(attendees)")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("\(newAttendee)", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("\(addAttendee)")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
