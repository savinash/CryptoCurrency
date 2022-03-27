//
//  CryptoDemoTests.swift
//  CryptoDemoTests
//
//  Created by Avinash Kumar on 25/03/22.
//

import XCTest
@testable import CryptoDemo
class CryptoDemoTests: XCTestCase {
    
    private var cryptoViewModel: CryptoViewModel!
    private var cryptoListViewModel : CryptoListViewModel!
    private var bitcoin : Bitcoin!
    override func setUp(){
        super.setUp()
        // Dummy data
        bitcoin = (Bitcoin(id: "Test Id", symbol: "Test Sympol", name: "Test Name", imageURL: "ImageUrl", currentPrice: 1.0, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1.0, high24h: 0.0, low24h: 1.1, priceChange: 1.0, priceChangePercentage: 1.0, marketCapChange: 1.0, marketCapChangePercentage: 1.0, circulatingSupply: 1.0, totalSupply: 999, maxSupply: 321, ath: 112, athChangePercentage: 1221, athDate: "TestDate", atl: 121, atlChangePercentage: 123, atlDate: "TestDate", roi: nil, lastUpdated: "TestDate"))

        // Testing the app models with dummy data
        self.cryptoViewModel = CryptoViewModel(bitcoin)
        self.cryptoListViewModel = CryptoListViewModel(bitcoins: [bitcoin])
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
