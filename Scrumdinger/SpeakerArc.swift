//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/27/23.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    
    private var degreesPerSpeaker: Double {
            360 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        // addition 1.0 degree is for visual separation between arc segments
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle {
        //sub 1.0 degree for visual seperation between arc segments
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

            
        }
    }
}


