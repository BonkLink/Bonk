//
//  SetProfileView.swift
//  RChat
//
//  Created by Jacques Sarraffe on 4/20/420.//
import UIKit
import SwiftUI
import RealmSwift

struct SetProfileView: View {
     var state = SingletonVM.sharedInstance.globalViewModel
    @Environment(\.realm) var userRealm
    @AppStorage("shouldShareLocation") var shouldShareLocation = false
    
    @Binding var isPresented: Bool

    @State private var displayName = ""
    @State private var photo: Photo?
    @State private var photoAdded = false
    
    
   
    
    var body: some View {
        Form {
            Section(header: Text("User Profile")) {
                if let photo = photo {
                    AvatarButton(photo: photo) {
                        self.showPhotoTaker()
                    }
                }
                if photo == nil {
                    Button(action: { self.showPhotoTaker() }) {
                        Text("Add Photo")
                    }
                }
                InputField(title: "Display Name", text: $displayName)
                CallToActionButton(title: "Save User Profile", action: saveProfile)
            }
            Section(header: Text("Device Settings")) {
                Toggle(isOn: $shouldShareLocation, label: {
                    Text("Share Location")
                })
                .onChange(of: shouldShareLocation) { value in
                    if value {
                        _ = LocationHelper.currentLocation
                    }
                }
                OnlineAlertSettings()
            }
        }
        .onAppear { initData() }
        .animation(.interactiveSpring())
//        .padding()
        .navigationTitle(Text(""))
        .navigationBarColor(.black)
        .navigationBarItems(
            leading: Button(action: { goBack() }) { BackButton() } .foregroundColor(Color.white)
        ,
            trailing:  LogoutButton()
        )
        
//        .navigationBarHidden(!state.isUserLoggedIn)
    }
    
    func goBack(){
        isPresented = false;
        if(state.user?.isProfileSet == true){
            print("SET!")
        }
    }
    
    private func initData() {
        displayName = state.user?.userPreferences?.displayName ?? ""
        photo = state.user?.userPreferences?.avatarImage
    }
    
    private func saveProfile() {
        
        state.indicateActivity = true
        do {
            try userRealm.write {
                state.user?.userPreferences?.displayName = displayName
                if photoAdded {
                    guard let newPhoto = photo else {
                        print("Missing photo")
                        state.indicateActivity = false
                        return
                    }
                    state.user?.userPreferences?.avatarImage = newPhoto
                }
                state.user?.presenceState = .onLine
                
                print(state.user?.isProfileSet)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        state.indicateActivity = false
    }

    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            photoAdded = true
            controller.hide()
        }
    }
}



struct SetProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        let previewState: AppState = .sample
        return AppearancePreviews(
            NavigationView {
                ZStack{
                    Color.red.edgesIgnoringSafeArea(.all)
                }
                SetProfileView(isPresented: .constant(true))
                .navigationBarColor(UIColor.black)
                    .navigationBarColor(.black)
            }
        )
//        .environmentObject(previewState)
    }
}


