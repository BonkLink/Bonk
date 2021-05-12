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
        HStack {
            if isMyMessage { Spacer().frame(width: Dimensions.horizontalOffset) }
            VStack {
                HStack {
                    if let authorName = authorName {
                        if isPreview {

                            AuthorView(userName: authorName)
                        } else {
                            AuthorView(userName: authorName)
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))
                        }
                    }
                    Spacer()

                }
                HStack {
                    VStack{
                    if let photo = chatMessage.image {
                        ThumbnailWithExpand(photo: photo)
                        .padding(Dimensions.padding)
                    }
                    if let location = chatMessage.location {
                        if location.count == 2 {
                            MapThumbnailWithExpand(location: location.map { $0 })
                                .padding(Dimensions.padding)
                        }
                    }
                    if chatMessage.text != "" {
                        Text(chatMessage.text)
                        .padding(Dimensions.padding)
                    }
                    }
                    Spacer()
                    Text(chatMessage.timestamp, style: isLessThanOneDay ?  .time : .date)
                        .font(.caption)
                }
            }
            .padding(Dimensions.padding)
            .background(isMyMessage ? AngularGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5641589796686748, saturation: 0.12724727033132532, brightness: 0.2943541745105422, opacity: 1.0), location: 0.07213040865384615), Gradient.Stop(color: Color(hue: 0.48528685052710846, saturation: 0.5224903520331325, brightness: 0.9699383471385543, opacity: 1.0), location: 0.07509765624999998), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.29244811276355426, brightness: 0.9866781579442772, opacity: 1.0), location: 0.6025916466346154), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.7577073317307692), Gradient.Stop(color: Color(hue: 0.8486298710466869, saturation: 0.247779202748494, brightness: 0.9528279132153615, opacity: 0.7566006212349399), location: 0.8840745192307692), Gradient.Stop(color: Color(hue: 0.5184223221009037, saturation: 1.0, brightness: 0.8, opacity: 1.0), location: 0.9629432091346155)]), center: UnitPoint.bottomTrailing, angle: .radians(0.7859215104450917)) : AngularGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5641589796686748, saturation: 0.12724727033132532, brightness: 0.2943541745105422, opacity: 1.0), location: 0.07213040865384615), Gradient.Stop(color: Color(hue: 0.48528685052710846, saturation: 0.5224903520331325, brightness: 0.9699383471385543, opacity: 1.0), location: 0.07509765624999998), Gradient.Stop(color: Color(hue: 0.7560623352786146, saturation: 0.25429158038403615, brightness: 1.0, opacity: 1.0), location: 0.6025916466346154), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.7577073317307692), Gradient.Stop(color: Color(hue: 0.8486298710466869, saturation: 0.247779202748494, brightness: 0.9528279132153615, opacity: 0.7566006212349399), location: 0.8840745192307692), Gradient.Stop(color: Color(hue: 0.5184223221009037, saturation: 1.0, brightness: 0.8, opacity: 1.0), location: 0.9629432091346155)]), center: UnitPoint.bottomTrailing, angle: .radians(0.7859215104450917)))
           
            .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
            if !isMyMessage { Spacer().frame(width: Dimensions.horizontalOffset) }
        }
    }
}

//struct ChatBubbleView_Previews: PreviewProvider {
//    static var previews: some View {
//        //ChatBubbleView()
//        Text("needs to be fixed")
//    }
//}
