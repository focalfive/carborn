//
//  CategoryNavigationController.swift
//  carborn
//
//  Created by pureye4u on 19/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit

class CategoryNavigationController: UIViewController, CrossNavigationControllerDelegate {
    
    private var crossNavigationController = CrossNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crossNavigationController.horizontalPageLimit = 5
        self.crossNavigationController.verticalPageLimit = 5
        self.crossNavigationController.view.backgroundColor = .black
        self.crossNavigationController.delegate = self
        self.view.addSubview(self.crossNavigationController.view)
    }
    
    func navigationDidScrollToVertical(page: Int, offset: CGFloat) {
        print("vertical \(page) \(offset)")
    }
    
    func navigationDidScrollToHorizontal(page: Int, offset: CGFloat) {
        print("horizontal \(page) \(offset)")
    }
}
