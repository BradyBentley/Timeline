//
//  Post.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    
    // MARK: - Properties
    var photoData: Data?
    let timestamp: Date
    let caption: String
    let comments: [Comment]
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.6)
        }
    }
    
    // MARK: - Initialization
    init(photo: UIImage, timestamp: Date = Date(), caption: String, comments: [Comment]){
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.photo = photo
    }
}
