//
//  PostListTableViewController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var commentSearchBar: UISearchBar!
    
    // MARK: - Properties
    var resultsArray: [SearchableRecord]?
    var isSearching: Bool = false
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commentSearchBar.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return resultsArray?.count ?? 0
        } else {
            return PostController.shared.posts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostTableViewCell
        if isSearching == true {
            let post = resultsArray?[indexPath.row] as? Post
            cell.post = post
        } else {
            let post = PostController.shared.posts[indexPath.row]
            cell.post = post
        }
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

// MARK: - SearchBarDelegate
extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let posts = PostController.shared.posts
        let filterPosts = posts.filter{ $0.matches(searchTerm: searchText)}.compactMap{ $0 as SearchableRecord }
        resultsArray = filterPosts
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsArray = PostController.shared.posts
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
