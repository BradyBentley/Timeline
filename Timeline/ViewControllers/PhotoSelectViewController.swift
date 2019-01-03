//
//  PhotoSelectViewController.swift
//  Timeline
//
//  Created by Brady Bentley on 1/2/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit
import UserNotifications

protocol PhotoSelectViewControllerDelegate: class{
    func photoSelectViewControllerSelected(image: UIImage)
}

class PhotoSelectViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoSelectImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: PhotoSelectViewControllerDelegate?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        presentAlertController()
    }
}

// MARK: - AlertController
extension PhotoSelectViewController {
    func presentAlertController() {
        let alertController = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        let imagePickeController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let addPhoto = UIAlertAction(title: "Photos", style: .default) { (_) in
                imagePickeController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickeController, animated: true, completion: nil)
            }
            alertController.addAction(addPhoto)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
                imagePickeController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickeController, animated: true, completion: nil)
            }
            alertController.addAction(camera)
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}

extension PhotoSelectViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageButton.setTitle("", for: .normal)
            photoSelectImageView.image = photo
            delegate?.photoSelectViewControllerSelected(image: photo)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



