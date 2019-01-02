//
//  PostListTableViewController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostTableViewCell
        let post = PostController.shared.posts[indexPath.row]
        cell.post = post
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "ToPostDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? PostDetailTableViewController
            let post = PostController.shared.posts[indexPath.row]
            destinationVC?.post = post
        }
    }
}
