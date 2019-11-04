//
//  NavigationController.swift
//  carborn
//
//  Created by jud.lee on 2019/11/04.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let rootViewController = MenuViewController()
        rootViewController.viewModel = MenuViewModel()
        super.init(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }
    
}
