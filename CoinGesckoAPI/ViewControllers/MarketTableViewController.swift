//
//  MarketTableViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

import UIKit

final class MarketTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var coins: [Coin] = []
    private var imageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let coinDetailVC = segue.destination as? CoinDetailTableViewController else { return }
            coinDetailVC.coin = coins[indexPath.row]
            if let cell = tableView.cellForRow(at: indexPath) as? CoinCell {
                coinDetailVC.image = cell.image
            }
        } else if let coinSearchVC = segue.destination as? CoinSearchTableViewController {
            coinSearchVC.coins = coins
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        guard let cell = cell as? CoinCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
}

// MARK: - Networking
extension MarketTableViewController {
    private func fetchCoins() {
        networkManager.fetchCoins(from: Link.coinsCategories.url) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
