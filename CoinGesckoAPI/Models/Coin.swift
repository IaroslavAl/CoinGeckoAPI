//
//  Coin.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

struct Coin: Decodable {
    let id: String
    let symbol: String
    let image: String
    let name: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24H: Double
    let low24H: Double
    let priceChange24H: Double
    let priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: String
    let currency: String?
    let lastUpdated: String
    let priceChangePercentage24HInCurrency: Double
}
