//
//  NavigationViewController.swift
//  CoinGesckoAPI
//
//  Created by Iaroslav Beldin on 10.05.2023.
//

import UIKit

final class NavigationViewController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .dark
    }
}
