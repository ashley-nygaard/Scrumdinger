//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/27/23.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
  
    let error = String(localized: "An error has occured")
    let dismissBtn = String(localized: "Dismiss" )
    let ignore = String(localized: "You can safely ignore")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(error)")
                    .font(.title)
                    .padding(.bottom)
                Spacer()
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(dismissBtn) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    static var wrapper: ErrorWrapper{
      ErrorWrapper(error: SampleError.errorRequired, guidance: String(localized:"You can safely ignore this error"))
    }
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
