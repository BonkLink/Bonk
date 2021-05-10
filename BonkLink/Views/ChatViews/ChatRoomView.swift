//
//  ChatRoomView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/20/21.
//

import SwiftUI

struct ChatRoomView: View {
    
    var state = SingletonVM.sharedInstance.globalViewModel
    @Environment(\.realm) var userRealm
    var conversation: Conversation?
    var isPreview = false
    
    let padding: CGFloat = 8
    
    var body: some View {
        //NavigationView{
            //ZStack{
        VStack {
            if let conversation = conversation {
                if isPreview {
                    ChatRoomBubblesView(conversation: conversation, isPreview: isPreview)
                } else {
                    ChatRoomBubblesView(conversation: conversation)
                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "conversation=\(conversation.id)"))
                }
            }
           
        }//}
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, padding)
        .padding(.bottom)
        .onAppear(perform: clearUnreadCount)
        .onDisappear(perform: clearUnreadCount)
        .navigationBarColor(UIColor.black)
        .frame(maxHeight: .infinity)
        .background(
          LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.bottom)
        //}
    }
    
    private func clearUnreadCount() {
        if let conversationId = conversation?.id {
            if let conversation = state.user?.conversations.first(where: { $0.id == conversationId }) {
                do {
                    try userRealm.write {
                        conversation.unreadCount = 0
                    }
                } catch {
                    print("Unable to clear chat unread count")
                }
            }
        }
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView()
    }
}
