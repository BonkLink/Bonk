//
//  NewConversationView.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI


import SwiftUI
import RealmSwift

struct NewConversationView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(Chatter.self) var chatsters
    
    var isPreview = false
    
    @State private var name = ""
    @State private var members = [String]()
    @State private var candidateMember = ""
    @State private var candidateMembers = [String]()
    
    private var isEmpty: Bool {
        !(name != "" && members.count > 0)
    }
    
    private var memberList: [String] {
        candidateMember == ""
            ? chatsters.compactMap {
                state.user?.userName != $0.UserName && !members.contains($0.UserName)
                    ? $0.UserName
                    : nil }
            : candidateMembers
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
                        ForEach(memberList, id: \.self) { candidateMember in
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
        var candidateChatsters: Results<Chatter>
        if candidateMember == "" {
            candidateChatsters = chatsters
        } else {
            let predicate = NSPredicate(format: "userName CONTAINS[cd] %@", candidateMember)
            candidateChatsters = chatsters.filter(predicate)
        }
        candidateMembers = []
        candidateChatsters.forEach { chatster in
            if !members.contains(chatster.UserName) && chatster.UserName != state.user?.userName {
                candidateMembers.append(chatster.UserName)
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
        Text("Fix this SAMPLE shit")
//        Realm.bootstrap()
//
//        return AppearancePreviews(
//            NewConversationView(isPreview: true)
//                .environmentObject(AppState.sample)
//        )
    }
}
