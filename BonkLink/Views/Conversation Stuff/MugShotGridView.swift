//
//  MugShotGridView.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI

import SwiftUI

struct MugShotGridView: View {
    let members: [Chatter]
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    private enum Dimensions {
        static let spacing: CGFloat = 0
        static let height: CGFloat = 50.0
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: rows, alignment: .center, spacing: Dimensions.spacing) {
                ForEach(members) { member in
                    UserAvatarView(
                        photo: member.avatarImage,
                        online: member.presenceState == .onLine ? true : false)
                }
            }
            .frame(height: Dimensions.height)
        }
    }
}

struct MugShotGridView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Fix this SAMPLE shit")
//        AppearancePreviews(
//            MugShotGridView(members: [.sample, .sample2, .sample3, .sample, .sample2,
//                                      .sample3, .sample, .sample2, .sample3, .sample, .sample2, .sample3])
//        )
//        .padding()
//        .previewLayout(.sizeThatFits)
    }
}

