//
//  ModelViewController.swift
//  carborn
//
//  Created by pureye4u on 23/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class ModelViewController: UIViewController, UIScrollViewDelegate {
    
    var _brandName = ""
    var brandName: String {
        get {
            return _brandName
        }
        set {
            if _brandName != newValue {
                _brandName = newValue
                self.brandView.brandName = newValue
            }
        }
    }
    
    var brandView = BrandView()
    var scrollView = UIScrollView()
    var initialBrandName: String!
    var initialScrollTouches: Set<UITouch>!
    var initialScrollEvent: UIEvent!
    
    convenience init(brandName: String, touces: Set<UITouch>, event: UIEvent) {
        self.init()
        
        // Initialize
        self.initialBrandName = brandName
        self.initialScrollTouches = touces
        self.initialScrollEvent = event
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Initialize view
        let frame = self.view.bounds
        let label = UILabel(frame: frame)
        label.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 100)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "ModelView"
        self.view.addSubview(label)
        
        self.initBrandView()
        self.initScrollView()
    }
    
    func initBrandView() {
        let viewSize = self.view.bounds
        let size = BrandView.defaultWidth
        let frame = CGRect(x: (viewSize.width - size) * 0.5, y: 0, width: size, height: size)
        self.brandView.frame = frame
        if let brandName = self.initialBrandName {
            self.brandView.brandName = brandName
        }
        self.view.addSubview(self.brandView)
    }
    
    func initScrollView() {
        var frame = self.view.bounds
        self.scrollView.frame = frame
        self.view.addSubview(self.scrollView)
        
        // Test
        let size: CGFloat = 100
        frame.origin.x = (frame.size.width - size) * 0.5
        frame.origin.y = 400
        frame.size.width = size
        frame.size.height = size
        for _ in 1...10 {
            let dot = UIView(frame: frame)
            dot.backgroundColor = .red
            dot.layer.cornerRadius = size * 0.5
            self.scrollView.addSubview(dot)
            frame.origin.y += size
        }
        
        let scrollSize = CGSize(width: self.view.bounds.width, height: frame.origin.y)
        self.scrollView.contentSize = scrollSize
        self.scrollView.delegate = self
        
        if let touches = self.initialScrollTouches, let event = self.initialScrollEvent {
            self.scrollView.touchesBegan(touches, with: event)
        }
    }
}
