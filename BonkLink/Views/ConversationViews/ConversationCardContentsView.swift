//
//  ConversationCardContentsView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
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
        var chatterList = [Chatter]()
        for member in conversation.members {
            chatterList.append(contentsOf: chatters.filter("userName = %@", member.userName))
        }
        return chatterList
    }
    
    var body: some View {
        HStack {
            MugShotGridView(members: chatMembers)
                .frame(width: Dimensions.mugWidth)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(conversation.displayName)
                    .foregroundColor(.white)
                    .fontWeight(conversation.unreadCount > 0 ? .bold : .bold)
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
//        ConversationCardContentsView(conversation: <#Conversation#>)
        Text("needs to be fixed")
    }
}
