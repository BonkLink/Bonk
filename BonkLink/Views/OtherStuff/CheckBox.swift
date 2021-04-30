//
//  CheckBox.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/30/21.
//

import SwiftUI

struct CheckBox: View {
    
    var title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: { self.isChecked.toggle() }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
            }
            .foregroundColor(isChecked ? .primary : .secondary)
        }
    }
}

//struct CheckBox_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBox()
//    }
//}
