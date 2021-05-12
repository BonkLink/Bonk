//
//  ConversationListView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/19/21.
//

import SwiftUI
import RealmSwift

struct ConversationListView: View {
    
    var state = SingletonVM.sharedInstance.globalViewModel
    @ObservedResults(Users.self) var users
    
    var isPreview = false
    
    @State private var conversation: Conversation?
    @State var showConversation = false
    @State var showingAddChat = false
    
    private let animationDuration = 0.5
    private let sortDescriptors = [
        SortDescriptor(keyPath: "unreadCount", ascending: false),
        SortDescriptor(keyPath: "displayName", ascending: true)
    ]
    
    var body: some View {
        ZStack {
            Image("background1").resizable().ignoresSafeArea()
            if let conversations = users[0].conversations.sorted(by: sortDescriptors) {
                
                ScrollView{
                    VStack {
                        ForEach(conversations, id:\.self) { conversation in
                            Button(action: {
                                self.conversation = conversation
                                showConversation.toggle()
                            }) { ConversationCardView(conversation: conversation, isPreview: isPreview) }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                

            }
           
            if isPreview {
                NavigationLink(
                    destination: ChatRoomView(conversation: conversation),
                    isActive: $showConversation) { EmptyView() }
                    .background(
                      LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
            } else {
                if let user = state.user {
                    NavigationLink(
                        destination: ChatRoomView(conversation: conversation)
                            .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(user._id)")),
                        isActive: $showConversation) { EmptyView() }
                        .background(
                          LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }

        .edgesIgnoringSafeArea(.bottom)


    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}




