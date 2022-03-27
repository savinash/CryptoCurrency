//
//  Bitcoin.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
/*
 Model class to provide the app model
 */
struct Bitcoin : Codable {
    var id : String
    var symbol : String
    var name : String
    var imageURL : String
    var currentPrice : Double
    var marketCap : Int
    var marketCapRank : Int
    var fullyDilutedValuation : Int
    var totalVolume : Double
    var high24h : Double
    var low24h : Double
    var priceChange : Double
    var priceChangePercentage : Double
    var marketCapChange : Double
    var marketCapChangePercentage : Double
    var circulatingSupply : Double
    var totalSupply : Double
    var maxSupply : Double
    var ath : Double
    var athChangePercentage : Double
    var athDate : String
    var atl : Double
    var atlChangePercentage : Double
    var atlDate : String
    var roi : Roi?
    var lastUpdated : String
    
    // Initialing the model properties
    init(id:String? = nil, symbol : String? = nil, name : String? = nil, imageURL : String? = nil, currentPrice : Double? = nil, marketCap : Int? = nil, marketCapRank : Int? = nil, fullyDilutedValuation : Int? = nil, totalVolume : Double? = nil, high24h : Double? = nil, low24h : Double? = nil, priceChange : Double? = nil, priceChangePercentage : Double? = nil, marketCapChange : Double? = nil, marketCapChangePercentage : Double? = nil, circulatingSupply : Double? = nil, totalSupply : Double? = nil, maxSupply : Double? = nil, ath : Double? = nil, athChangePercentage : Double? = nil, athDate : String? = nil, atl : Double? = nil, atlChangePercentage : Double? = nil, atlDate : String? = nil, roi : Roi? = nil, lastUpdated: String? = nil) {
        self.id = id ?? ""
        self.symbol = symbol ?? ""
        self.name = name ?? ""
        self.imageURL = imageURL ?? ""
        self.currentPrice = currentPrice ?? 0
        self.marketCap = marketCap ?? 0
        self.marketCapRank = marketCapRank ?? 0
        self.fullyDilutedValuation = fullyDilutedValuation ?? 0
        self.totalVolume = totalVolume ?? 0
        self.high24h = high24h ?? 0
        self.low24h = low24h ?? 0
        self.priceChange = priceChange ?? 0
        self.priceChangePercentage = priceChangePercentage ?? 0
        self.marketCapChange = marketCapChange ?? 0
        self.marketCapChangePercentage = marketCapChangePercentage ?? 0
        self.circulatingSupply = circulatingSupply ?? 0
        self.totalSupply = totalSupply ?? 0
        self.maxSupply = maxSupply ?? 0
        self.ath = ath ?? 0
        self.athChangePercentage = athChangePercentage ?? 0
        self.athDate = athDate ?? ""
        self.atl = atl ?? 0
        self.atlChangePercentage = atlChangePercentage ?? 0
        self.atlDate = atlDate ?? ""
        self.roi = roi
        self.lastUpdated = lastUpdated ?? ""
    }
}

/*
 Model for Roi object
 **/
struct Roi : Codable {
    var times : Double
    var currency : String
    var percentage : Double
    
    // Initializing the Roi properties
    init(times:Double? = nil, currency: String? = nil, percentage: Double? = nil) {
        self.times = times ?? 0.0
        self.currency = currency ?? ""
        self.percentage = percentage ?? 0.0
    }
}

/*
 Extension for Bitcoin model
 */
extension Bitcoin {
    // Enum for the JSon tag for decoding
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case imageURL = "image"
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
        case marketCapChange = "market_cap_change_24h"
        case marketCapChangePercentage = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath = "ath"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi = "roi"
        case lastUpdated = "last_updated"
    }
    // Decoding the JSon tags
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        currentPrice = try container.decodeIfPresent(Double.self, forKey: .currentPrice) ?? 0
        marketCap = try container.decodeIfPresent(Int.self, forKey: .marketCap) ?? 0
        marketCapRank = try container.decodeIfPresent(Int.self, forKey: .marketCapRank) ?? 0
        fullyDilutedValuation = try container.decodeIfPresent(Int.self, forKey: .fullyDilutedValuation) ?? 0
        totalVolume = try container.decodeIfPresent(Double.self, forKey: .totalVolume) ?? 0
        high24h = try container.decodeIfPresent(Double.self, forKey: .high24h) ?? 0
        low24h = try container.decodeIfPresent(Double.self, forKey: .low24h) ?? 0
        priceChange = try container.decodeIfPresent(Double.self, forKey: .priceChange) ?? 0
        priceChangePercentage = try container.decodeIfPresent (Double.self, forKey: .priceChangePercentage) ?? 0
        marketCapChange = try container.decodeIfPresent(Double.self, forKey: .marketCapChange) ?? 0
        marketCapChangePercentage = try container.decodeIfPresent(Double.self, forKey: .marketCapChangePercentage) ?? 0
        circulatingSupply = try container.decodeIfPresent(Double.self, forKey: .circulatingSupply) ?? 0
        totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupply) ?? 0
        maxSupply = try container.decodeIfPresent(Double.self, forKey: .maxSupply) ?? 0
        ath = try container.decodeIfPresent(Double.self, forKey: .ath) ?? 0
        athChangePercentage = try container.decodeIfPresent(Double.self, forKey: .athChangePercentage) ?? 0
        athDate = try container.decode(String.self, forKey: .athDate)
        atl = try container.decodeIfPresent(Double.self, forKey: .atl) ?? 0
        atlChangePercentage = try container.decodeIfPresent(Double.self, forKey: .atlChangePercentage) ?? 0
        atlDate = try container.decode(String.self, forKey: .atlDate)
        roi = try container.decodeIfPresent(Roi.self, forKey: .roi)
        lastUpdated = try String(container.decode(String.self, forKey: .lastUpdated))
    }
}
/*
 Roi model extension
 */
extension Roi {
    
    // Enum for Json tags
    private enum CodingKeys: String, CodingKey {
        case times = "times"
        case currency = "currency"
        case percentage = "percentage"
    }
    
    // Decoding the JSon tags
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        times = try container.decodeIfPresent(Double.self, forKey: .times) ?? 0
        currency = try container.decode(String.self, forKey: .currency)
        percentage = try container.decodeIfPresent(Double.self, forKey: .percentage) ?? 0
    }
}
