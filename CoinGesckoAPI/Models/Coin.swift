//
//  Coin.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

struct Coin: Decodable {
    let symbol: String
    let image: String
    let name: String
    let currentPrice: Double
    let marketCapRank: Int
    let marketCap: Double
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24H: Double
    let low24H: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let priceChangePercentage24H: Double
}
