//
//  AddPostTableViewController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var captionTextField: UITextField!
    
    // MARK: - Properties
    var photo: UIImage?
    
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let photo = photo, let caption = captionTextField.text, !caption.isEmpty else { return }
        PostController.shared.createPostWith(image: photo, caption: caption) { (_) in
            print("Yay")
        }
        captionTextField.text = ""

        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "ToImageVC" {
            guard let destinationVC = segue.destination as? PhotoSelectViewController else { return }
            destinationVC.delegate = self
        }
    }
    
}

// PhotoSelectViewControllerDelegate
extension AddPostTableViewController: PhotoSelectViewControllerDelegate {
    func photoSelectViewControllerSelected(image: UIImage) {
        self.photo = image
    }
    
    
}
