//
//  CryptoDetailsViewController.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
import UIKit
/*
 Class to display the other details of crypto currency of selected crypto currency
 */
class CryptoDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var bitcoin : Bitcoin? = nil
    
    @IBOutlet weak var cryptoImageView: UIImageView!
    @IBOutlet weak var cryptoScrollView: UIScrollView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceChange24Label: UILabel!
    @IBOutlet weak var priceChangePercentage24Label: UILabel!
    @IBOutlet weak var high24Label: UILabel!
    @IBOutlet weak var low24Label: UILabel!
    @IBOutlet weak var marketRankLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var marketChange24Label: UILabel!
    @IBOutlet weak var marketChangePercentage24Label: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var circulatingSupplyLabel: UILabel!
    @IBOutlet weak var totalSupplyLabel: UILabel!
    @IBOutlet weak var totalVolumeLabel: UILabel!
    @IBOutlet weak var fullyDilutedValuationLabel: UILabel!
    @IBOutlet weak var athLabel: UILabel!
    @IBOutlet weak var athChangePercentageLabel: UILabel!
    @IBOutlet weak var athDateLabel: UILabel!
    @IBOutlet weak var atlLabel: UILabel!
    @IBOutlet weak var atlChangePercentageLabel: UILabel!
    @IBOutlet weak var atlDateLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    // ScrollView delegate method to lock the horizontal scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cryptoScrollView.contentOffset.x = 0
    }
    
    // Downloading the related image and displaying. Reusing the extension created for imageView
    func setUp(){
        self.navigationItem.title = bitcoin?.name
        if let imageUrl = bitcoin?.imageURL {
            cryptoImageView.downloadImageData(imageURL: imageUrl, contentMode: UIView.ContentMode.scaleAspectFit)
            self.setupLabel()
        }
    }
}

/*
 Setting up the UI items to show the details for the selected crypto currany 
 */
extension CryptoDetailsViewController {
    
    func setupLabel(){
        if let currentPrice = self.bitcoin?.currentPrice {
            currentPriceLabel.text = String(currentPrice)
        }
        if let priceChange = self.bitcoin?.priceChange {
            priceChange24Label.text = String(priceChange)
        }
        if let priceChangePercentage = self.bitcoin?.priceChangePercentage {
            priceChangePercentage24Label.text = String(priceChangePercentage)
        }
        if let high24h = self.bitcoin?.high24h {
            high24Label.text = String(high24h)
        }
        if let low24h = self.bitcoin?.low24h {
            low24Label.text = String(low24h)
        }
        if let marketCapRank = self.bitcoin?.marketCapRank {
            if marketCapRank != 0 {
                marketRankLabel.text = String(marketCapRank)
            }else{
                marketRankLabel.text = "-"
            }
        }
        if let marketCap = self.bitcoin?.marketCap {
            if marketCap != 0 {
                marketCapLabel.text = String(marketCap)
            }else{
                marketCapLabel.text = "-"
            }
        }
        if let marketCapChange = self.bitcoin?.marketCapChange {
            if marketCapChange != 0 {
                marketChange24Label.text = String(marketCapChange)
            }else{
                marketChange24Label.text = "-"
            }
        }
        if let marketCapChangePercentage = self.bitcoin?.marketCapChangePercentage {
            if marketCapChangePercentage != 0 {
                marketChangePercentage24Label.text = String(marketCapChangePercentage)
            }else{
                marketChangePercentage24Label.text = "-"
            }
        }
        if let maxSupply = self.bitcoin?.maxSupply {
            if maxSupply != 0 {
                maxSupplyLabel.text = String(maxSupply)
            }else{
                maxSupplyLabel.text = "-"
            }
        }
        if let circulatingSupply = self.bitcoin?.circulatingSupply {
            if circulatingSupply != 0 {
                circulatingSupplyLabel.text = String(circulatingSupply)
            }else{
                circulatingSupplyLabel.text = "-"
            }
        }
        if let totalSupply = self.bitcoin?.totalSupply {
            if totalSupply != 0 {
                totalSupplyLabel.text = String(totalSupply)
            }else{
                totalSupplyLabel.text = "-"
            }
        }
        if let totalVolume = self.bitcoin?.totalVolume {
            if totalVolume != 0 {
                totalVolumeLabel.text = String(totalVolume)
            }else{
                totalVolumeLabel.text = "-"
            }
        }
        if let fullyDilutedValuation = self.bitcoin?.fullyDilutedValuation {
            if fullyDilutedValuation != 0 {
                fullyDilutedValuationLabel.text = String(fullyDilutedValuation)
            }else{
                fullyDilutedValuationLabel.text = "-"
            }
        }
        if let ath = self.bitcoin?.ath {
            if ath != 0 {
                athLabel.text = String(ath)
            }else{
                athLabel.text = "-"
            }
        }
        if let athChangePercentage = self.bitcoin?.athChangePercentage {
            if athChangePercentage != 0 {
                athChangePercentageLabel.text = String(athChangePercentage)
            }else{
                athChangePercentageLabel.text = "-"
            }
        }
        if let athDate = self.bitcoin?.athDate {
            athDateLabel.text = String(athDate)
        }
        if let atl = self.bitcoin?.atl {
            if atl != 0 {
                atlLabel.text = String(atl)
            }else{
                atlLabel.text = "-"
            }
        }
        if let atlChangePercentage = self.bitcoin?.atlChangePercentage {
            if atlChangePercentage != 0 {
                atlChangePercentageLabel.text = String(atlChangePercentage)
            }else{
                atlChangePercentageLabel.text = "-"
            }
        }
        if let atlDate = self.bitcoin?.atlDate {
            atlDateLabel.text = String(atlDate)
        }
        if let lastUpdated = self.bitcoin?.lastUpdated {
            lastUpdatedLabel.text = String(lastUpdated)
        }
        
        if bitcoin?.roi != nil {
            if let times = self.bitcoin?.roi?.times {
                timesLabel.text = String(times)
            }
            if let currency = self.bitcoin?.roi?.currency {
                currencyLabel.text = String(currency)
            }
            if let percentage = self.bitcoin?.roi?.percentage {
                percentageLabel.text = String(percentage)
            }
        }else{
            timesLabel.text = "-"
            currencyLabel.text = "-"
            percentageLabel.text = "-"
        }
    }
}



