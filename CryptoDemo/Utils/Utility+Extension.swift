//
//  Utility+Extension.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
import UIKit
/*
 Class for different extensions used in the app
 */

// Extension for UIImageView to download the data using URLSession data task and load the image from imageUrl. It also takes content mode parameter so as to display the image as required
extension UIImageView {
    func downloadImageData(imageURL : String, contentMode: UIView.ContentMode) {
        guard let link = URL(string: imageURL) else {
            return
        }
        URLSession.shared.dataTask(with: link, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    self.contentMode = contentMode
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

// Extension for displaying alert in app. It takes string parameters for message and title
extension UIViewController {
    func displayAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

