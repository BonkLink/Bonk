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
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
            }
        }

        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)


    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}


//Curious how I generated that linear gradient? Check out this utility for creating gradients!
//  https://apps.apple.com/us/app/gradient-maker/id1528484462?mt=12

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.6071600856551206, saturation: 1.0, brightness: 0.8, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.4552134318524097, saturation: 1.0, brightness: 0.8, opacity: 0.9545133659638555), location: 0.07780198317307692), Gradient.Stop(color: Color(hue: 0.5591732163027109, saturation: 0.6641213290662651, brightness: 0.8043227597891567, opacity: 1.0), location: 0.3454477163461539)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}


