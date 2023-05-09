//
//  TabBarViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 10.05.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }
}
