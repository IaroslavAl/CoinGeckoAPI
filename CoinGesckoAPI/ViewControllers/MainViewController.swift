//
//  MainViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 09.05.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var coins: [Coin] = []
    private var loadedCoins: [Coin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
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
extension MainViewController {
    private func fetchCoins() {
        networkManager.fetch([Coin].self, from: Link.coinsCategories.url) { [weak self] result in
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
