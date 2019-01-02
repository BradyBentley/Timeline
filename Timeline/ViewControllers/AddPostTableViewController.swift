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
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    // MARK: - Properties
    var photo: UIImage?
    
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func addImageButtonTapped(_ sender: Any) {
        previewImageView.image = UIImage(named: "invaderzim")
        print("It worked")
    }
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let photo = previewImageView.image, let caption = captionTextField.text, !caption.isEmpty else { return }
        PostController.shared.createPostWith(image: photo, caption: caption) { (_) in
            print("Yay")
        }
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
}
