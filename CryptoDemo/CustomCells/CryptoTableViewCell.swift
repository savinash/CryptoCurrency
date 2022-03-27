//
//  CryptoTableViewCell.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
import UIKit

/*
 Class for TableViewCell. It will take Bitcoin data model and set the values to UI objects
 */
class CryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var cryptoImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePercentageLabel: UILabel!
    
    //Method to configure the cell with Bitcoin data model
    func configureCell(cellData : Bitcoin?)  {
        self.displayNameLabel.text = cellData?.name
        self.priceLabel.text = String(cellData?.currentPrice ?? 0)
        self.pricePercentageLabel.text  = "\(cellData?.priceChangePercentage ?? 0) %"
        if let imageURL = cellData?.imageURL { // Method to download the image and set to image. Written downloadImage extension for this task
            self.cryptoImage.downloadImageData(imageURL: imageURL, contentMode: UIView.ContentMode.scaleAspectFit)
        }
    }
}


