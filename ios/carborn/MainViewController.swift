//
//  MainViewController.swift
//  carborn
//
//  Created by pureye4u on 27/12/2016.
//  Copyright © 2016 slowslipper. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Initialize view
        let viewFrame = self.view.bounds
        var frame = viewFrame
        let label = UILabel(frame: frame)
        label.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 100)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Main"
        self.view.addSubview(label)
        
        let size = CGFloat(200)
        frame.size.width = size;
        frame.size.height = size;
        frame.origin.x = (viewFrame.size.width - frame.size.width) * 0.5
        frame.origin.y = viewFrame.size.height - frame.size.height - 20
        let buttonBrand = UIButton(frame: frame)
        buttonBrand.setTitle("Brand", for: .normal)
        buttonBrand.setTitleColor(.black, for: .normal)
        buttonBrand.titleLabel?.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 50)
        buttonBrand.backgroundColor = .white
        buttonBrand.layer.cornerRadius = size * 0.5
        buttonBrand.addTarget(self, action: #selector(navigateToBrand), for: .touchUpInside)
        self.view.addSubview(buttonBrand)
    }
    
    func navigateToBrand() {
        let dummy = CrossNavigationController()
        dummy.scrollWidth = 200
        self.navigationController?.pushViewController(dummy, animated: true)
//        self.navigationController?.pushViewController(BrandListViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

