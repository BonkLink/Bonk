//
//  SampleData.swift
//  BonkLink
//
//  Created by Jacques Sarraffe on 4/18/21.
//

import SwiftUI

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
    static var samples: [Item] { get }
}


extension Date {
    static var random: Date {
        Date(timeIntervalSince1970: (50 * 365 * 24 * 3600 + Double.random(in: 0..<(3600 * 24 * 365))))
    }
}

extension AppState {
    convenience init(user: Users) {
        self.init()
        self.user = user
    }
}

    
  
extension Photo {
    convenience init(photoName: String) {
        self.init()
        self.thumbNail = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.picture = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.date = Date.random
    }
    convenience init(_ photo: Photo?) {
        self.init()
        if let photo = photo {
            self.thumbNail = photo.thumbNail
            self.picture = photo.picture
            self.date = photo.date
        }
    }
}



