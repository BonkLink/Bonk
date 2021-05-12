//
//  ContentView.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import SwiftUI
import UserNotifications
import RealmSwift


struct ContentView: View {
     var currState = SingletonVM.sharedInstance.globalViewModel
    //Remind users after 12 hours that they're logged in!
    @AppStorage("remindUserOnline") var remindOnLineUser = false;
    @AppStorage("reminderUserHours") var remindHours = 12.0;
    
    
    @State var showProfile = false;
    
    
    var action: () -> Void = {}
    
    @State var showNewChat = false;
    
    
    var body: some View {
        ZStack{
            
        NavigationView{
            
                VStack{
                    
                    if currState.isUserLoggedIn {
                        if(currState.user!.userPreferences?.displayName == "" || showProfile){
                            
                            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                                SetProfileView(isPresented: $showProfile)
                                   .environment(\.realmConfiguration,
                                               app.currentUser!.configuration(partitionValue: "user=\(currState.user?._id ?? "")"))
                            }
                            
                        }

                        else if(currState.user?.isProfileSet == true){
                            ConversationListView()

                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(currState.user?._id ?? "")"))
                            .navigationBarTitle("Chats", displayMode: .inline)
                            .navigationBarItems(
                                leading: Button("New Chat") {
                                    self.showNewChat.toggle()
                                }.sheet(isPresented: $showNewChat){
                                                NewConversationView()
                                                    .environmentObject(currState)
                                                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))
                                                    .background(
                                                      LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom))
                                } ,
                                trailing: currState.isUserLoggedIn && !currState.indicateActivity ? UserAvatarView(
                                    photo: currState.user?.userPreferences?.avatarImage,
                                    online: true) { showProfile.toggle() } : nil
                            )
             
                                .navigationBarColor(.black)
                        }
                    }
             
                    else{
                    Login()
                    }
                    if let error = currState.error {
                              Text("Error: \(error)")
                                  .foregroundColor(Color.red)
                    }
                }
      
        }
        
        .currentDeviceNavigationViewStyle(alwaysStacked: !currState.isUserLoggedIn )
        }
        
    }
}



extension View {
    public func currentDeviceNavigationViewStyle(alwaysStacked: Bool) -> AnyView {
        if UIDevice.current.userInterfaceIdiom == .pad && !alwaysStacked {
            return AnyView(self.navigationViewStyle(DefaultNavigationViewStyle()))
        } else {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                ContentView()
            
    }
}





