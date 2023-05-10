//
//  CoinDetailTableViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 10.05.2023.
//

import UIKit

final class CoinDetailTableViewController: UITableViewController {
    
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var coinLabel: UILabel!
    @IBOutlet var currentPriceLabel: UILabel!
    
    var coin: Coin!
    var image: UIImage!
    
    private let properties = [
        "Market Cap Rank",
        "Market Cap",
        "Fully Diluted Valuation",
        "Trading Volume",
        "24H High",
        "24H Low",
        "Available Supply",
        "Total Supply",
        "Max Supply",
        "24H Price Change"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel.image = image
        coinLabel.text = "\(coin.name) (\(coin.symbol.uppercased()))"
        currentPriceLabel.text = "$\(removeZeros(coin.currentPrice, decimalNumbers: 8, minimumFractionDigits: 2))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        properties.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinDetailCell", for: indexPath)
        guard let cell = cell as? CoinDetailCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.secondTextLabel.text = "#\(coin.marketCapRank)"
        case 1:
            cell.secondTextLabel.text = "$\(removeZeros(coin.marketCap))"
        case 2:
            if let fullyDilutedValuation = coin.fullyDilutedValuation {
                cell.secondTextLabel.text = "$\(removeZeros(fullyDilutedValuation))"
            } else {
                cell.secondTextLabel.text = "?"
            }
        case 3:
            cell.secondTextLabel.text = "$\(removeZeros(coin.totalVolume))"
        case 4:
            cell.secondTextLabel.text = "$\(removeZeros(coin.high24H, decimalNumbers: 8, minimumFractionDigits: 2))"
        case 5:
            cell.secondTextLabel.text = "$\(removeZeros(coin.low24H, decimalNumbers: 8, minimumFractionDigits: 2))"
        case 6:
            cell.secondTextLabel.text = "$\(removeZeros(coin.circulatingSupply))"
        case 7:
            if let totalSupply = coin.totalSupply {
                cell.secondTextLabel.text = "\(removeZeros(totalSupply))"
            } else {
                cell.secondTextLabel.text = "?"
            }
        case 8:
            if let maxSupply = coin.maxSupply {
                cell.secondTextLabel.text = "\(removeZeros(maxSupply))"
            } else {
                cell.secondTextLabel.text = "?"
            }
        default:
            cell.secondTextLabel.text = "\(removeZeros(coin.priceChangePercentage24H, decimalNumbers: 1, minimumFractionDigits: 1))%"
        }
        
        cell.propertyLabel.text = properties[indexPath.row]
        return cell
    }
    
    private func removeZeros(_ double: Double, decimalNumbers: Int? = nil, minimumFractionDigits: Int? = nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalNumbers ?? 0
        formatter.minimumFractionDigits = minimumFractionDigits ?? 0
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ","
        let string = formatter.string(from: NSNumber(value: double)) ?? ""
        return string
    }
}
