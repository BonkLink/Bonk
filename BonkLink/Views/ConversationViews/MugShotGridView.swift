//
//  MugShotGridView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
//

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
        //MugShotGridView(members: <#T##[Chatter]#>)
        Text("Needs to be fixed")
    }
}
