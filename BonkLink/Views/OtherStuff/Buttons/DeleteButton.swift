//
//  DeleteButton.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct DeleteButton: View {
    
    let action: () -> Void
    var active = true
    var padding: CGFloat = 8
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "minus.square.fill", inactiveImage: "minus.square", padding: padding)
    }
}

//struct DeleteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteButton()
//    }
//}
