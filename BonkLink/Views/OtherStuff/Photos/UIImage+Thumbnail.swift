//
//  UIImage+Thumbnail.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/30/21.
//

import SwiftUI
import UIKit

extension UIImage {
    func thumbnail(size: CGFloat) -> UIImage? {
        var thumbnail: UIImage?
        guard let imageData = self.pngData() else {
            return nil
        }
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: size] as CFDictionary
        
        imageData.withUnsafeBytes { ptr in
            if let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self),
               let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count),
               let source = CGImageSourceCreateWithData(cfData, nil),
               let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) {
                thumbnail = UIImage(cgImage: imageReference)
            }
        }
        
        return thumbnail
    }
}


