//
//  ChatInputBox.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/20/21.
//

import SwiftUI
import RealmSwift

struct ChatInputBox: View {
    
    @EnvironmentObject var state: AppState
    @AppStorage("shouldShareLocation") var shouldShareLocation = false
    
    var send: (_: ChatMessage) -> Void = { _ in }
    var focusAction: () -> Void = {}
    
    private enum Dimensions {
        static let maxHeight: CGFloat = 100
        static let minHeight: CGFloat = 100
        static let radius: CGFloat = 10
        static let imageSize: CGFloat = 70
        static let padding: CGFloat = 15
        static let toolStripHeight: CGFloat = 35
    }
    
    @State var photo: Photo?
    @State var chatText = ""
    @State var location =  [Double]()
    
    private var isEmpty: Bool { photo == nil && location == [] && chatText == "" }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    private func addLocation() {
        let location = LocationHelper.currentLocation
        self.location = [location.longitude, location.latitude]
    }
    
    private func takePhoto() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
    
    private func addAttachment() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
    
    private func deletePhoto() {
        photo = nil
    }
    
    private func deleteMap() {
        location = []
    }
    
    private func sendChat() {
        sendMessage(text: chatText, photo: photo, location: location)
        photo = nil
        chatText = ""
        location = []
    }
    
    private func clearBackground() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    private func sendMessage(text: String, photo: Photo?, location: [Double]) {
            let chatMessage = ChatMessage(
                author: state.user?.userName ?? "Unknown",
                test: text,
                image: photo,
                location: location)
            send(chatMessage)
    }
    
}

struct ChatInputBox_Previews: PreviewProvider {
    static var previews: some View {
        //ChatInputBox()
        Text("needs to be fixed")
    }
}
