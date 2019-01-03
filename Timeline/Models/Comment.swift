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
    
    // CloudKit
    let ckRecordId: CKRecord.ID
    let postReference: CKRecord.Reference
    
    // MARK: - Keys
    enum CommentKeys {
        static let text = "text"
        static let timestamp = "timestamp"
        static let post = "Post"
        static let postReference = "postReference"
    }
    
    // MARK: - Initialization
    init(text: String, timestamp: Date = Date(), post: Post, ckRecordId: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), postReference: CKRecord.Reference){
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.ckRecordId = ckRecordId
        self.postReference = postReference
    }
    
    
    convenience init?(ckRecord: CKRecord){
        guard let text = ckRecord[CommentKeys.text] as? String,
            let timestamp = ckRecord.creationDate,
            let post = ckRecord[CommentKeys.post] as? Post,
            let postReference = ckRecord[CommentKeys.postReference] as? CKRecord.Reference else { return nil }
        let ckRecordId = ckRecord.recordID
        self.init(text: text, timestamp: timestamp, post: post, ckRecordId: ckRecordId, postReference: postReference)
    }
}

extension CKRecord {
    convenience init(_ comment: Comment) {
        self.init(recordType: Comment.CommentKeys.post, recordID: comment.ckRecordId)
        setValue(comment.text, forKey: Comment.CommentKeys.text)
        setValue(comment.timestamp, forKey: Comment.CommentKeys.timestamp)
        setValue(comment.postReference, forKey: Comment.CommentKeys.postReference)
        setValue(comment.post, forKey: Comment.CommentKeys.post)
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return self.text.lowercased().contains(searchTerm.lowercased())
    }
}


