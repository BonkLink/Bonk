//
//  NewConversationView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
//

import SwiftUI
import RealmSwift

struct NewConversationView: View {
    
    @EnvironmentObject var state: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(Chatter.self) var chatters
    
    var isPreview = false
    
    @State private var name = ""
    @State private var members = [String]()
    @State private var candidateMember = ""
    @State private var candidateMembers = [String]()
    
    private var isEmpty: Bool {
        !(name != "" && members.count > 0)
    }
    
    var body: some View {
        let searchBinding = Binding<String>(
            get: { candidateMember },
            set: {
                candidateMember = $0
                searchUsers()
            }
        )
        
        return NavigationView {
            ZStack {
                VStack {
                    InputField(title: "Chat Name", text: $name)
                    CaptionLabel(title: "Add Members")
                    SearchBox(searchText: searchBinding)
                    List {
                        ForEach(candidateMembers, id: \.self) { candidateMember in
                            Button(action: { addMember(candidateMember) }) {
                                HStack {
                                    Text(candidateMember)
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                    .renderingMode(.original)
                                }
                            }
                        }
                    }
                    Divider()
                    CaptionLabel(title: "Members")
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                        }
                        .onDelete(perform: deleteMember)
                    }
                    Spacer()
                }
                Spacer()
                if let error = state.error {
                    Text("Error: \(error)")
                        .foregroundColor(Color.red)
                }
            }
            .padding()
            .navigationBarTitle("New Chat", displayMode: .inline)
            .navigationBarItems(trailing: VStack {
                if isPreview {
                    SaveConversationButton(name: name, members: members, done: { presentationMode.wrappedValue.dismiss() })
                } else {
                    SaveConversationButton(name: name, members: members, done: { presentationMode.wrappedValue.dismiss() })
                    .environment(
                        \.realmConfiguration,
                        app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                }
            }
            .disabled(isEmpty)
            .padding()
            )
        }
        .onAppear(perform: searchUsers)
    }
    
    private func searchUsers() {
         var candidateChatters: Results<Chatter>
         if candidateMember == "" {
             candidateChatters = chatters
         } else {
             let predicate = NSPredicate(format: "userName CONTAINS[cd] %@", candidateMember)
             candidateChatters = chatters.filter(predicate)
         }
         candidateMembers = []
         candidateChatters.forEach { chatter in
             if !members.contains(chatter.UserName) && chatter.UserName != state.user?.userName {
                 candidateMembers.append(chatter.UserName)
             }
         }
     }
    
    private func addMember(_ newMember: String) {
        state.error = nil
        if members.contains(newMember) {
            state.error = "\(newMember) is already part of this chat"
        } else {
            members.append(newMember)
            candidateMember = ""
            searchUsers()
        }
    }
    
    private func deleteMember(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
    }
}

struct NewConversationView_Previews: PreviewProvider {
    static var previews: some View {
        NewConversationView()
    }
}