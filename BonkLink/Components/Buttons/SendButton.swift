//
//  SendButton.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI

struct SendButton: View {
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "paperplane.fill", inactiveImage: "paperplane")
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                SendButton(action: {}, active: false)
                SendButton(action: {})
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
