//
//  AuthorView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/20/21.
//

import SwiftUI

import RealmSwift

struct AuthorView: View {
    @ObservedResults(Chatter.self) var chatsters
     let userName: String
     
     var chatster: Chatter? {
         chatsters.filter("userName = %@", userName).first
     }
     
    
    private enum Dimensions {
        static let authorHeight: CGFloat = 25
        static let padding: CGFloat = 4
    }
//    
    var body: some View {
        Text("Fix this SAMPLE shit");
//        if let author = chatster {
//            HStack {
//                if let photo = author.avatarImage {
//                    AvatarThumbNailView(photo: photo, imageSize: Dimensions.authorHeight)
//                }
//                if let name = author.displayName {
//                    Text(name)
//                    .font(.caption)
//                } else {
//                    Text(author.userName)
//                        .font(.caption)
//                }
//                Spacer()
//            }
//            .frame(maxHeight: Dimensions.authorHeight)
//            .padding(Dimensions.padding)
//        }
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        
        Text("Fix this SAMPLE shit");
//        Realm.bootstrap()
//
//        return AppearancePreviews(AuthorView(userName: "rod@contoso.com"))
//            .previewLayout(.sizeThatFits)
//            .padding()
    }
}
