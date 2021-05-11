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
        VStack {
            if let conversations = users[0].conversations.sorted(by: sortDescriptors) {
                List {
                    ForEach(conversations) { conversation in
                        Button(action: {
                            self.conversation = conversation
                            showConversation.toggle()
                        }) { ConversationCardView(conversation: conversation, isPreview: isPreview)
                            .animation(.interactiveSpring())
                        }
                    }
                    .listRowBackground(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.8756412368222892, saturation: 0.6700248258659639, brightness: 0.8247158556099399, opacity: 1.0), location: 0.05122445913461538), Gradient.Stop(color: Color(hue: 0.9293462914156627, saturation: 0.7479615728539157, brightness: 0.668630576995482, opacity: 0.9545133659638555), location: 0.15966045673076923), Gradient.Stop(color: Color(hue: 0.13326548381024098, saturation: 0.2811264589608434, brightness: 0.7844238281250001, opacity: 1.0), location: 0.5290564903846153), Gradient.Stop(color: Color(hue: 0.6981215879141567, saturation: 0.4372029132153615, brightness: 1.0, opacity: 1.0), location: 0.8149188701923078)]), startPoint: UnitPoint.leading, endPoint: UnitPoint.topTrailing))
                    
//                    Button(action: { showingAddChat.toggle() }) {
//                        Text("New Chat Room")
//                    }
//                    .buttonStyle(BlueButton())
//                    .disabled(showingAddChat)
//                    .padding()
//                    
                    .listRowBackground(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.8756412368222892, saturation: 0.6700248258659639, brightness: 0.8247158556099399, opacity: 1.0), location: 0.05122445913461538), Gradient.Stop(color: Color(hue: 0.9293462914156627, saturation: 0.7479615728539157, brightness: 0.668630576995482, opacity: 0.9545133659638555), location: 0.15966045673076923), Gradient.Stop(color: Color(hue: 0.13326548381024098, saturation: 0.2811264589608434, brightness: 0.7844238281250001, opacity: 1.0), location: 0.5290564903846153), Gradient.Stop(color: Color(hue: 0.6981215879141567, saturation: 0.4372029132153615, brightness: 1.0, opacity: 1.0), location: 0.8149188701923078)]), startPoint: UnitPoint.leading, endPoint: UnitPoint.topTrailing))
  
                }
                .animation(.easeIn(duration: animationDuration))

            }
           
            if isPreview {
                NavigationLink(
                    destination: ChatRoomView(conversation: conversation),
                    isActive: $showConversation) { EmptyView() }
                    .background(
                      LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
                    .animation(.easeIn(duration: animationDuration))
            } else {
                if let user = state.user {
                    NavigationLink(
                        destination: ChatRoomView(conversation: conversation)
                            .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(user._id)")),
                        isActive: $showConversation) { EmptyView() }
                        .background(
                          LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
                        .animation(.easeIn(duration: animationDuration))
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


