//
//  BonkLinkApp.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

//Entry point of the app


//Some notes:
//We have sent so many tests to our db (over 10gb of test data) that MongoDB has throttled us.
//Therefore, when new accounts are created, it takes a long time to populate the member list when creating new
//chats.

//An account that you can login into that's guaranteed to have all the chatters populated and work quicker than a new account:
//username: guy
//password: test123

//Class demo accounts:
//demoClass1 \ test123
//demoClass 2 \ test123


//For generating gradients, I used this free app. It works very well! https://apps.apple.com/us/app/gradient-maker/id1528484462?mt=12

import SwiftUI
import RealmSwift
let app = RealmSwift.App(id: "bonklink-cytqk")

@main
struct BonkLinkApp: SwiftUI.App {
    @ObservedObject var state = SingletonVM.sharedInstance.globalViewModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
