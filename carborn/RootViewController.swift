//
//  RootViewController.swift
//  carborn
//
//  Created by jud.lee on 2019/12/28.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var beginPoint: CGPoint = .zero
    private var isControlTouched = false
//    {
//        didSet {
////            guard isControlTouched != oldValue else {
////                return
////            }
//            view.add
//        }
//    }
    private let navigation = NavigationController()
    private let controlButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navigation.view)
        
        let controlSize: CGFloat = 60
        let controlMargin: CGFloat = 40
        
        controlButton.backgroundColor = .white
        controlButton.layer.cornerRadius = controlSize * 0.5
        view.addSubview(controlButton)
        controlButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(controlMargin)
            $0.right.equalToSuperview().inset(controlMargin)
            $0.size.equalTo(controlSize)
        }
        controlButton.addTarget(self, action: #selector(buttonDidTouchDown), for: .touchDown)
        controlButton.addTarget(self, action: #selector(buttonDidTouchUp), for: .touchUpInside)
        controlButton.addTarget(self, action: #selector(buttonDidTouchUp), for: .touchUpOutside)
    }
    
    @objc private func buttonDidTouchDown() {
        print("buttonDidTouchDown")
        isControlTouched = true
    }
    
    @objc private func buttonDidTouchUp() {
        print("buttonDidTouchUp")
        isControlTouched = false
    }
    
}
