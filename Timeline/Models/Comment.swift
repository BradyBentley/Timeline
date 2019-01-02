//
//  Comment.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    // MARK: - Properties
    let text: String
    let timestamp: Date
    weak var post: Post?
    
    // MARK: - Initialization
    init(text: String, timestamp: Date = Date(), post: Post){
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
}


