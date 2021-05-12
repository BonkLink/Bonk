//
//  OnOffCircleView.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//


import SwiftUI

struct OnOffCircleView: View {
    let online: Bool
    
    private enum Dimensions {
        static let frameSize: CGFloat = 14.0
        static let innerCircleSize: CGFloat = 10
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: Dimensions.frameSize, height: Dimensions.frameSize)
            Circle()
                .fill(online ? Color.green : Color.red)
                .frame(width: Dimensions.innerCircleSize, height: Dimensions.innerCircleSize)
        }
    }
}

struct OnOffCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                OnOffCircleView(online: true)
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
