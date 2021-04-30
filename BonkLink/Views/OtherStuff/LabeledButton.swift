//
//  LabeledButton.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/30/21.
//

import SwiftUI

struct LabeledButton: View {
    
    let label: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            LabeledText(label: label, text: text)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//struct LabeledButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LabeledButton()
//    }
//}
