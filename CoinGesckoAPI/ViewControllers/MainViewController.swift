//
//  MainViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCoins() {
        networkManager.fetch([Coin].self, from: Link.coinsCategories.url) { result in
            switch result {
            case .success(let coins):
                print(coins)
            case .failure(let error):
                print(error)
            }
        }
    }
}
