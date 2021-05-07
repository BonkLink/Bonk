//
//  SaveConversationButton.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
//

import SwiftUI
import RealmSwift

struct SaveConversationButton: View {
    
    var state = SingletonVM.sharedInstance.globalViewModel
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
        guard let userName = state.user?.userName else {
            state.error = "Current user is not set"
            return
        }
        conversation.members.append(Member(userName: userName, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
        state.indicateActivity = true
        do {
            try userRealm.write {
                state.user?.conversations.append(conversation)
                members.map { Member($0) }
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
        //SaveConversationButton(name: <#String#>, members: <#[String]#>)
        Text("needs to be fixed")
    }
}
