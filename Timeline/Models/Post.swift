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
    var recordId = CKRecord.ID(recordName: UUID().uuidString)
    var photoData: Data?
    let timestamp: Date
    let caption: String
    var comments: [Comment]
    var tempUrl: URL?
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.6)
        }
    }
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirecotryUrl = URL(fileURLWithPath: tempDirectory)
            let fileUrl = tempDirecotryUrl.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            self.tempUrl = fileUrl
            do {
                try photoData?.write(to: fileUrl)
            } catch let error {
                print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileUrl)
        }
    }
    
    deinit {
        if let url = tempUrl {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("Error deleting temp file, or may cause memory leak: \(error)")
            }
        }
    }
    
    // MARK: - Keys
    enum PostKeys {
        static let recordTypeKey = "Post"
        static let timestampKey = "timestamp"
        static let captionKey = "caption"
        static let photoData = "photoData"
    }
    
    
    // MARK: - Initialization
    init(photo: UIImage, timestamp: Date = Date(), caption: String, comments: [Comment] = []){
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.photo = photo
    }
    
    init?(ckRecord: CKRecord) {
        guard let caption = ckRecord[PostKeys.captionKey] as? String,
        let timestamp = ckRecord.creationDate,
            let imageAsset = ckRecord[PostKeys.photoData] as? CKAsset else { return nil }
        guard let photoData = try? Data(contentsOf: imageAsset.fileURL) else { return nil }
        
        self.caption = caption
        self.timestamp = timestamp
        self.photoData = photoData
        self.comments = []
        self.recordId = ckRecord.recordID
    }
}

extension CKRecord {
    convenience init(_ post: Post){
        self.init(recordType: Post.PostKeys.recordTypeKey, recordID: post.recordId)
        setValue(post.timestamp, forKey: Post.PostKeys.timestampKey)
        setValue(post.imageAsset, forKey: Post.PostKeys.photoData)
        setValue(post.caption, forKey: Post.PostKeys.captionKey)
    }
}

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if self.caption.lowercased().contains(searchTerm.lowercased()){
            return true
        }
        for comment in self.comments {
            if comment.matches(searchTerm: searchTerm){
                return true
            }
        }
        return false
    }
}
