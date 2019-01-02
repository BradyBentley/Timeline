//
//  PostController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

class PostController {
    
    // MARK: - Properties
    static let shared = PostController()
    
    var posts: [Post] = []
    
    // MARK: - CRUD Functions
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void) {
        let newComment = Comment(text: text, post: post)
        post.comments.append(newComment)
        completion(newComment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post) -> Void) {
        let newPost = Post(photo: image, caption: caption)
        self.posts.append(newPost)
        completion(newPost)
    }
    
}
