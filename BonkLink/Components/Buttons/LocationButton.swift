//
//  LocationButton.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI

import SwiftUI

struct LocationButton: View {
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "location.fill", inactiveImage: "location")
    }
}

struct LocationButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                LocationButton(action: {}, active: false)
                LocationButton(action: {})
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
