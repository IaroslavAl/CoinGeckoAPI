//
//  CoinSearchTableViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 10.05.2023.
//

import UIKit

final class CoinSearchTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var coins: [Coin]!
    
    private var filteredCoins: [Coin] = []
    private var searchBarIsEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let coinDetailVC = segue.destination as? CoinDetailTableViewController else { return }
            coinDetailVC.coin = filteredCoins[indexPath.row]
            if let cell = tableView.cellForRow(at: indexPath) as? SearchCoinCell {
                coinDetailVC.image = cell.image
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCoins.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCoinCell", for: indexPath)
        guard let cell = cell as? SearchCoinCell else { return UITableViewCell() }
        var coin: Coin
        
        if isFiltering {
            coin = filteredCoins[indexPath.row]
        } else {
            coin = coins[indexPath.row]
        }
        
        cell.configure(with: coin)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension CoinSearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCoins = coins.filter { coin in
            return coin.name.lowercased().contains(searchText.lowercased()) || coin.symbol.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
