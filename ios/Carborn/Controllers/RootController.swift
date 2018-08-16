//
//  RootController.swift
//  carborn
//
//  Created by pureye4u on 16/08/2018.
//  Copyright © 2018 slowslipper. All rights reserved.
//

import UIKit

class RootController: UINavigationController {
    
    // MARK: Shared instance
    static let shared: RootController = RootController()
    
    init() {
        super.init(rootViewController: MainViewController())
        self.navigationBar.isHidden = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
