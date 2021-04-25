//
//  SaveConversationButton.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/25/21.
//

import SwiftUI
import RealmSwift

struct SaveConversationButton: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    
    let name: String
    let members: [String]
    var done: () -> Void = { }
    
    var body: some View {
        Button(action: saveConversation) {
            Text("Save")
        }
    }
    
    private func saveConversation() {
        state.error = nil
        let conversation = Conversation()
        conversation.displayName = name
        
        // FIX THIS SHIT
//        guard let userName = state.user?.userName else {
//            state.error = "Current user is not set"
//            return
//        }
        //   FIX THIS SHIT
        
//        conversation.members.append(Member(userName: userName, state: .active))
//        conversation.members.append(objectsIn: members.map { Member($0) })
        state.indicateActivity = true
        do {
            try userRealm.write {
                state.user?.conversations.append(conversation)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
            state.indicateActivity = false
            return
        }
        state.indicateActivity = false
        done()
    }
}

struct SaveConversationButton_Previews: PreviewProvider {
    static var previews: some View {
        return AppearancePreviews(
            SaveConversationButton(
                name: "Example Conversation",
                members: ["rod@contoso.com", "jane@contoso.com", "freddy@contoso.com"])
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
