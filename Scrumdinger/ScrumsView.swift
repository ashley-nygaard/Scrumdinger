//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/22/23.
//

import SwiftUI


struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    // observe this value and save data when it becomes inactive
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: ()->Void
  
  let daily = String(localized: "Daily Scrums")
  let addNew = String(localized: "Add a new scrum")
  let dismiss = String(localized:"Dimiss")
  let add = String(localized: "Add")

    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                        
                }
                .listRowBackground(scrum.theme.mainColor)
               
            }
        }
        .navigationTitle(daily)
        .toolbar {
            Button(action: {
                isPresentingNewScrumView = true
            }){
                Image(systemName: "plus")
            }
            .accessibilityLabel(addNew)
                
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NavigationView {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(dismiss) {
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()

                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(add) {
                                let newScrum = DailyScrum(data: newScrumData)
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
        
    }
}
