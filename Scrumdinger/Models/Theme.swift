//
//  Theme.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/21/23.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    // Each of the above was added manually to the localizable file
    
    var accentColor: Color {
        switch self {
            case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
            case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }

    var mainColor: Color {
        Color(rawValue)
    }

    var name: String {
      return NSLocalizedString(self.rawValue.capitalized, comment: "color")
    }
    
    var id: String {
        name
    }
  

    
}

