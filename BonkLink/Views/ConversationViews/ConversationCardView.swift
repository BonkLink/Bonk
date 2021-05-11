//
//  ConversationCardView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
//

import SwiftUI
import RealmSwift

struct ConversationCardView: View {
    
    let conversation: Conversation
    var isPreview = false
    
    var body: some View {
        VStack {
            if isPreview {
                ConversationCardContentsView(conversation: conversation)
                    .transition(.opacity)
            } else {
                ConversationCardContentsView(conversation: conversation)
                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))
                    .transition(.opacity)
            }
        }
        .background(
          LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .border(Color.black, width: 1)
    }
}

struct ConversationCardView_Previews: PreviewProvider {
    static var previews: some View {
        //ConversationCardView()
        Text("Needs to be fixed")
    }
}
