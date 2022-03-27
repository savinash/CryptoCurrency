//
//  Constants.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation

/*
 Class for providing different constants used in the application
 */
struct Constants {
    // Providing URL to get the list of Crypto currency Rates
    struct Urls {
        static let criptoURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    }
    
    // Providing string values used in Alert
    struct AlertValues {
        static let reachabilityTitle = "Network not available"
        static let reachabilityMessage = "Please connect to network and try again"
        static let appErrorTitle = "Error"
        static let appErrorMessage = "We are sorry. Some error occured please try again later"
        
    }
    
    // Providing commonly strings used strings in the app
    struct CommonStrings {
        static let refeshControllerMessage = "Refreshing..."
        static let cryptoCellIdentifier = "CryptoTableViewCell"
        static let cellNotFoundError = "CustomeCell not found"
        static let navigationError = "NavigationController not found"
        static let controllerError = "CryptoDetailsViewController not found"
        static let identifierString = "CryptoDetailsSegue"
    }
    
}


