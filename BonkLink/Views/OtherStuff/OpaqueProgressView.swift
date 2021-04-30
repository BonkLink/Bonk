//
//  OpaqueProgressView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/30/21.
//

import SwiftUI

struct OpaqueProgressView: View {
    
    var message: String?

    private enum Dimensions {
        static let padding: CGFloat = 100
        static let bgColor = Color("Clear")
        static let cornerRadius: CGFloat = 25
    }

    init() {
        message = nil
    }

    init(_ message: String?) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            if let message = message {
                ProgressView(message)
            } else {
                ProgressView()
            }
        }
        .padding(Dimensions.padding)
        .background(Dimensions.bgColor)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }
}

//struct OpaqueProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpaqueProgressView()
//    }
//}
