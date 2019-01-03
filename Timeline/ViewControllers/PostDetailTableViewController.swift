//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit
import UserNotifications

class PostDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Properties
    var post: Post?{
        didSet {
            updateViews()
        }
    }

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    // MARK: - IBActions
    @IBAction func commentButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let post = post, let photo = post.photo else { return }
        let activityViewController = UIActivityViewController(activityItems: [photo, post.caption], applicationActivities: nil)
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true)
        }
    }
    @IBAction func followPostButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Functions
    func updateViews() {
//        guard let post = post else { return }
//        photoImageView.image = post.photo
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath)
        let comment = post?.comments[indexPath.row]
        cell.textLabel?.text = comment?.text
        return cell
    }
}

// MARK: - Alerts
extension PostDetailTableViewController {
    func presentAlertController() {
        let alertController = UIAlertController(title: "Add Comment", message: "Comment on this Post", preferredStyle: .alert)
        alertController.addTextField { (addCommentTextField) in
            addCommentTextField.placeholder = "Enter Comment here"
        }
        let addAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            guard var addTextField = alertController.textFields?.first?.text, let post = self.post else { return }
            PostController.shared.addComment(text: addTextField, post: post, completion: { (comment) in
                DispatchQueue.main.async {
                    addTextField = comment.text
                    self.tableView.reloadData()
                }
            })
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
