//
//  SearchCoinCell.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 10.05.2023.
//

import UIKit

final class SearchCoinCell: UITableViewCell {
    
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var marketCapRankLabel: UILabel!
    
    var image: UIImage!
    private let networkManager = NetworkManager.shared
    
    func configure(with coin: Coin) {
        symbolLabel.text = coin.symbol.uppercased()
        marketCapRankLabel.text = "#\(coin.marketCapRank)"
        coinNameLabel.text = coin.name
        
        networkManager.fetchImage(from: URL(string: coin.image)!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.image = UIImage(data: imageData)
                self?.coinImage.image = self?.image
            case .failure(let error):
                print(error)
            }
        }
    }
}
