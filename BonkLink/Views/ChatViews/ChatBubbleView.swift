//
//  ChatBubbleView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/20/21.
//

import SwiftUI

struct ChatBubbleView: View {
    
    let chatMessage: ChatMessage
    let authorName: String?
    var isPreview = false
    
    private var isLessThanOneDay: Bool { chatMessage.timestamp.timeIntervalSinceNow > -60 * 60 * 24 }
    private var isMyMessage: Bool { authorName == nil }
    
    private enum Dimensions {
        static let padding: CGFloat = 4
        static let horizontalOffset: CGFloat = 100
        static let cornerRadius: CGFloat = 15
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        //ChatBubbleView()
        Text("needs to be fixed")
    }
}
