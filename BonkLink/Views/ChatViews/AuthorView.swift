//
//  AuthorView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/20/21.
//

import SwiftUI
import RealmSwift

struct AuthorView: View {
    
    @ObservedResults(Chatter.self) var chatters
    let userName: String
    
    var chatter: Chatter? {
        chatters.filter("userName = %@", userName).first
    }
    
    private enum Dimensions {
        static let authorHeight: CGFloat = 25
        static let padding: CGFloat = 4
    }
    
    var body: some View {
        if let author = chatter {
            HStack {
                if let photo = author.avatarImage {
                    AvatarThumbnailView(photo: photo, imageSize: Dimensions.authorHeight)
                }
                if let name = author.displayName {
                    Text(name)
                    .font(.caption)
                } else {
                    Text(author.UserName)
                        .font(.caption)
                }
                Spacer()
            }
            .frame(maxHeight: Dimensions.authorHeight)
            .padding(Dimensions.padding)
        }
    }
}

//struct AuthorView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthorView(, userName: <#String#>)
//    }
//}
