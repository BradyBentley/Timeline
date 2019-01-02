//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Brady Bentley on 1/1/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Functions
    func updateView(){
        guard let post = post else { return }
        postImageView.image = post.photo
        captionLabel.text = post.caption
        numberOfCommentsLabel.text = "Comments: \(post.comments.count)"
    }
}
