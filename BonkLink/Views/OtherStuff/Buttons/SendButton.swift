//
//  SendButton.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct SendButton: View {
    
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "paperplane.fill", inactiveImage: "paperplane")
    }
}

//struct SendButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SendButton()
//    }
//}
