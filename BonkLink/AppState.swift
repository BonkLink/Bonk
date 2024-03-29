//
//  AppState.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//



//This is the "boiler plate" code for setting up a Realm instance

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject{
    
    @Published var error: String?
    @Published var busyCounter = 0
    
    @Published var showProf = false;
    
    @Published var loginPublish = PassthroughSubject<RealmSwift.User, Error>()
    @Published var logoutPublish = PassthroughSubject<Void, Error>()
    @Published var userRealmPublish = PassthroughSubject<Realm, Error>()
    @Published var cancellable = Set<AnyCancellable>()
    
   
    var indicateActivity = false;
    
    @Published var chatterRealm: Realm?
    @Published var userRealm: Realm?
    @Published var user: Users?
    
    var isUserLoggedIn: Bool{
        app.currentUser != nil && userRealm != nil && app.currentUser?.state == .loggedIn
    }
    
    init(){
        _ = app.currentUser?.logOut()
        userRealm = nil
        initLoginPublish()
        initUserRealmPublish()
        initLogoutPublisher()
    }
    
    func initLoginPublish(){
        loginPublish
            .receive(on: DispatchQueue.main)
            .flatMap{user->RealmPublishers.AsyncOpenPublisher in
                self.indicateActivity = true
                let realmConfiguration = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfiguration)
            }
            .receive(on: DispatchQueue.main)
            .map{
                return $0
            }
            .subscribe(userRealmPublish)
            .store(in: &self.cancellable)
    }
    
    func initUserRealmPublish(){
        userRealmPublish
            .sink(receiveCompletion: {result in
                if case let .failure(error) = result{
                    self.error = "Failed to login and open realm. \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                self.userRealm = realm
                print("User realm location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(Users.self).first
                do{
                    try realm.write {
                        self.user?.presenceState = .onLine
                    }
                } catch {
                    self.error = "Unable to open Realm transaction"
                }
                self.indicateActivity = false
            })
            .store(in: &cancellable)
    }
    
    func initLogoutPublisher() {
        logoutPublish
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }, receiveValue: { _ in
                self.user = nil
                self.userRealm = nil
            })
            .store(in: &cancellable)
    }
    
}
