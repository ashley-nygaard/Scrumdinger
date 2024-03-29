/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
  
  let info = String(localized: "Meeting Info" )
  let start = String(localized: "Start Meeting")
  let length = String(localized: "Length")
  let min = String(localized: "minutes")
  let theme = String(localized: "Theme", comment: "Theme color for meeting")
  let attendees = String(localized: "Attendees", comment: "Detailview page")
  let history = String(localized: "History", comment: "DetailView History section")
  let noHistory = String(localized: "No meetings yet")
  let edit = String(localized: "Edit")
  let cancel = String(localized: "Cancel")
  let done = String(localized: "Done")
  
    
    var body: some View {
        List {
            Section(header: Text("\(info)")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label(start, systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label(length, systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) \(min) ")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label(theme, systemImage: "paintpalette")
                    Spacer()
                  Text(String(localized: "\(scrum.theme.name.localizedCapitalized)", comment: "color chosen by user"))
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("\(attendees)")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("\(history)")){
                if scrum.history.isEmpty {
                    Label(noHistory, systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(scrum.history) {history in
                        NavigationLink(destination: HistoryView(history: history)){
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                      
                    }
                }
            }
        }
        // not localized by us, user created field
        .navigationTitle(scrum.title)
        .toolbar {
            Button(edit) {
                isPresentingEditView = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(cancel) {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(done) {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
