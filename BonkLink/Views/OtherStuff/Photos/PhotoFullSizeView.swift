//
//  PhotoFullSizeView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct PhotoFullSizeView: View {
    
    let photo: Photo

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if let picture = photo.picture {
                if let image = UIImage(data: picture) {
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            BackButton(label: "Dismiss")
        })
    }
}

//struct PhotoFullSizeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoFullSizeView()
//    }
//}
