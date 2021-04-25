//
//  ConversationCardContentsView.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI
import RealmSwift

struct ConversationCardContentsView: View {
    @ObservedResults(Chatter.self) var chatters
    
    let conversation: Conversation
    
    private struct Dimensions {
        static let mugWidth: CGFloat = 110
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 1
        static let padding: CGFloat = 5
    }
    
    var chatMembers: [Chatter] {
        var chatsterList = [Chatter]()
        for member in conversation.members {
            chatsterList.append(contentsOf: chatters.filter("userName = %@", member.userName))
        }
        return chatsterList
    }
    
    var body: some View {
        HStack {
            MugShotGridView(members: chatMembers)
                .frame(width: Dimensions.mugWidth)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(conversation.displayName)
                    .fontWeight(conversation.unreadCount > 0 ? .bold : .regular)
                CaptionLabel(title: conversation.unreadCount == 0 ? "" :
                        "\(conversation.unreadCount) new \(conversation.unreadCount == 1 ? "message" : "messages")")
            }
            Spacer()
        }
        .padding(Dimensions.padding)
        .overlay(
            RoundedRectangle(cornerRadius: Dimensions.cornerRadius)
                .stroke(Color.gray, lineWidth: Dimensions.lineWidth)
        )
    }
}

struct ConversationCardContentsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Fix this SAMPLE shit")
//        Realm.bootstrap()
//
//        return AppearancePreviews(
//            ForEach(Conversation.samples) { conversation in
//                ConversationCardContentsView(conversation: conversation)
//            }
//        )
//        .previewLayout(.sizeThatFits)
    }
}