//
//  Thumbnail.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct Thumbnail: View {
    
    let imageData: Data
    
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage()))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

//struct Thumbnail_Previews: PreviewProvider {
//    static var previews: some View {
//        Thumbnail()
//    }
//}
