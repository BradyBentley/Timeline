//
//  PostController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

class PostController {
    
    // MARK: - Properties
    static let shared = PostController()
    
    var posts: [Post] = []
    
    // MARK: - CloudKit Availability
    func checkAccountStatus(completion: @escaping (_ success: Bool) -> Void){
        CKContainer.default().accountStatus { (status, error) in
            if let error = error {
                print("Error checking accountStatus \(error) \(error.localizedDescription)")
                completion(false)
                return
            } else {
                let errorTextMessage = "Sign into iCloud in settings"
                switch status {
                case .available:
                    completion(true)
                case .couldNotDetermine:
                    self.presentErrorAlert(errorTitle: errorTextMessage, errorMessage: "Error finding iCloud Account")
                    completion(false)
                case .noAccount:
                    self.presentErrorAlert(errorTitle: errorTextMessage, errorMessage: "No iCloud account found")
                    completion(false)
                case .restricted:
                    self.presentErrorAlert(errorTitle: errorTextMessage, errorMessage: "Restricted iCloud Account")
                    completion(false)
                }
            }
            
        }
    }
    
    func presentErrorAlert(errorTitle: String, errorMessage: String){
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate,
                let appWindow = appDelegate.window!,
                let rootViewController = appWindow.rootViewController {
                rootViewController.showAlertMessage(titleMessage: errorTitle, message: errorMessage)
            }
        }
    }
    // MARK: - CRUD Functions
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void) {
        //        let newComment = Comment(text: text, post: post)
        //        post.comments.append(newComment)
        //        completion(newComment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let newPost = Post(photo: image, caption: caption)
        self.posts.append(newPost)
        CKContainer.default().publicCloudDatabase.save(CKRecord(newPost)) { (_, error) in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(newPost)
        }
    }
}

