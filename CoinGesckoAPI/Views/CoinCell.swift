//
//  CoinTableViewCell.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

import UIKit

class CoinCell: UITableViewCell {
    
    @IBOutlet var marketCapRankLabel: UILabel!
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var currentPriceLabel: UILabel!
    @IBOutlet var priceChangePercentage24HLabel: UILabel!
    @IBOutlet var marketCapLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with coin: Coin) {
        marketCapRankLabel.text = "\(coin.marketCapRank)"
        symbolLabel.text = coin.symbol.uppercased()
        currentPriceLabel.text = "$\(removeZeros(coin.currentPrice, decimalNumbers: 8, minimumFractionDigits: 2))"
        priceChangePercentage24HLabel.text = "\(removeZeros(coin.priceChangePercentage24H, decimalNumbers: 1, minimumFractionDigits: 1))%"
        marketCapLabel.text = "$\(removeZeros(coin.marketCap, decimalNumbers: 0, minimumFractionDigits: 0))"
        
        networkManager.fetchImage(from: URL(string: coin.image)!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.coinImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        priceChangePercentage24HLabel.textColor = coin.priceChangePercentage24H >= 0
        ? .systemGreen
        : .systemRed
    }
    
    private func removeZeros(_ double: Double, decimalNumbers: Int, minimumFractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalNumbers
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ","
        let string = formatter.string(from: NSNumber(value: double)) ?? ""
        return string
    }
}
