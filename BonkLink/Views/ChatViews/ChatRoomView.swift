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
        VStack {
            if let conversation = conversation {
                if isPreview {
                    Spacer()
                    ChatRoomBubblesView(conversation: conversation, isPreview: isPreview)
                } else {
                    Spacer()
                    ChatRoomBubblesView(conversation: conversation)
                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "conversation=\(conversation.id)"))
                }
            }
            Spacer()
        }
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, padding)
        .padding(.bottom)
        .onAppear(perform: clearUnreadCount)
        .onDisappear(perform: clearUnreadCount)
        .navigationBarColor(UIColor.black)
        .frame(maxHeight: .infinity)
        .background(
          LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.48528685052710846, saturation: 0.5224903520331325, brightness: 0.9699383471385543, opacity: 1.0), location: 0.1349308894230769), Gradient.Stop(color: Color(hue: 0.8, saturation: 0.3008665521460844, brightness: 0.9866781579442772, opacity: 1.0), location: 0.38061147836538467), Gradient.Stop(color: Color(hue: 0.5184223221009037, saturation: 1.0, brightness: 0.8, opacity: 1.0), location: 0.7052584134615385)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
        .edgesIgnoringSafeArea(.bottom)
       
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
