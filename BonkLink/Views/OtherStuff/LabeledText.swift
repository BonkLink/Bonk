//
//  LabeledText.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/30/21.
//

import SwiftUI

struct LabeledText: View {
    
    let label: String
    let text: String

    private let lineLimit = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            CaptionLabel(title: label)
            Text("\(text)")
                .font(.body)
                .lineLimit(lineLimit)
        }
    }
}

//struct LabeledText_Previews: PreviewProvider {
//    static var previews: some View {
//        LabeledText()
//    }
//}
