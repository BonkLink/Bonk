
//
//  UserProfileButton.swift
//  RChat
//
//  Created by Jacques Sarraffe on 4/20/21
import SwiftUI

struct UserProfileButton: View {
    @EnvironmentObject var state: AppState

    let action: () -> Void

    var body: some View {
        Button("Profile", action: action)
        .disabled(state.indicateActivity)
    }
}

//struct UserProfileButton_Previews: PreviewProvider {
//    static var previews: some View {
//        return AppearancePreviews(
//            UserProfileButton(action: { }
//
//            )
//        )
//        .padding()
//        .previewLayout(.sizeThatFits)
////        .environmentObject(AppState.sample)
//    }
//}
