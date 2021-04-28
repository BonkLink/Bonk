//
//  ThumbnailView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI

struct ThumbnailView: View {
    
    let photo: Photo?
    private let compressionQuality: CGFloat = 0.8
    
    var body: some View {
        VStack {
            if let photo = photo {
                if photo.thumbNail != nil || photo.picture != nil {
                    if let photo = photo.thumbNail {
                        Thumbnail(imageData: photo)
                    } else {
                        if let photo = photo.picture {
                            Thumbnail(imageData: photo)
                        } else {
                            Thumbnail(imageData: UIImage().jpegData(compressionQuality: compressionQuality)!)
                        }
                    }
                }
            }
        }
    }
}

//struct ThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailView(photo: <#Photo?#>)
//    }
//}
