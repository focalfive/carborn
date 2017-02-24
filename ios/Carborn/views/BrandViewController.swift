//
//  BrandViewController.swift
//  Carborn
//
//  Created by pureye4u on 23/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController, UIScrollViewDelegate {
    
    static let defaultWidth: CGFloat = 300
    static let defaultMargin: CGFloat = 20
    
    var labelTitle = UILabel()
    var baseView = UIView()
    
    var _brandName: String = ""
    var brandName: String {
        get {
            return _brandName
        }
        set {
            if _brandName != newValue {
                _brandName = newValue
                self.labelTitle.text = newValue
            }
        }
    }
    
    var modelScrollView = UIScrollView()
    
    var frame: CGRect {
        get {
            return self.view.frame
        }
        set {
            self.view.frame = newValue
            self.sizeToFitViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialzie
        let viewSize = self.view.bounds.size
        let baseViewSize = BrandViewController.defaultWidth
        var frame = CGRect.zero
        frame.size.width = baseViewSize
        frame.size.height = baseViewSize
        frame.origin.x = (viewSize.width - baseViewSize) * 0.5
        
        self.baseView.frame = frame
        self.baseView.backgroundColor = .white
        self.baseView.layer.cornerRadius = baseViewSize * 0.5
        self.view.addSubview(self.baseView)
        
        let labelFrame = CGRect(origin: .zero, size: frame.size)
        self.labelTitle.frame = labelFrame
        self.labelTitle.textColor = .black
        self.labelTitle.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 50)
        self.labelTitle.textAlignment = .center
        self.baseView.addSubview(self.labelTitle)
        
        let scrollViewFrame = CGRect(origin: .zero, size: frame.size)
        self.modelScrollView.frame = scrollViewFrame
        self.modelScrollView.clipsToBounds = false
        self.modelScrollView.isPagingEnabled = true
        
        self.view.addSubview(self.modelScrollView)
        
        var dummyFrame = CGRect(origin: .zero, size: scrollViewFrame.size)
        dummyFrame.origin.y = 100
        dummyFrame.size.height = 100
        for i in 0..<10 {
            let label = UILabel(frame: dummyFrame)
            label.textColor = .red
            label.textAlignment = .center
            label.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 30)
            label.text = "Dummy \(i)"
            self.modelScrollView.addSubview(label)
            
            dummyFrame.origin.y += dummyFrame.size.height
        }
        
        let scrollSize = CGSize(width: scrollViewFrame.size.width, height: frame.size.height * 10)
        self.modelScrollView.contentSize = scrollSize
        self.modelScrollView.delegate = self
    }
    
    func sizeToFitViews() {
        let viewSize = self.view.bounds.size
        
        var baseFrame = self.baseView.frame
        baseFrame.origin.x = (viewSize.width - baseFrame.size.width) * 0.5
        self.baseView.frame = baseFrame
        
        baseFrame.origin = .zero
        self.labelTitle.frame = baseFrame
        
        self.modelScrollView.frame = CGRect(origin: .zero, size: viewSize)
        
        let scrollSize = CGSize(width: viewSize.width, height: viewSize.height * 10)
        self.modelScrollView.contentSize = scrollSize
    }
    
}
