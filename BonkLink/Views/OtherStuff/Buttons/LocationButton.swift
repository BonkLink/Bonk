//
//  LocationButton.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct LocationButton: View {
    
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "location.fill", inactiveImage: "location")
    }
}

//struct LocationButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationButton()
//    }
//}
