//
//  UIViewControllerExtension.swift
//  Timeline
//
//  Created by Brady Bentley on 1/3/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertMessage(titleMessage: String, message: String) {
        let alertController = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}


