//
//  BrandView.swift
//  carborn
//
//  Created by pureye4u on 25/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit

class BrandView: UIView {
    
    static let circleSize: CGFloat = 300
    private var baseView = UIView()
    private var labelTitle = UILabel()
    var title: String {
        get {
            return self.labelTitle.text ?? ""
        }
        set {
            self.labelTitle.text = newValue
        }
    }
    private var _circleScale: CGFloat = 1
    var circleScale: CGFloat {
        get {
            return self._circleScale
        }
        set {
            if self._circleScale != newValue {
                self._circleScale = newValue
                self.resetCircleSize()
            }
        }
    }
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(width: BrandView.circleSize, height: BrandView.circleSize))
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        // Initialzie
        let viewSize = CGSize(width: BrandView.circleSize, height: BrandView.circleSize)
        var frame = CGRect.zero
        frame.size = viewSize
//        frame.origin.x = -BrandView.circleSize * 0.5
//        frame.origin.y = -BrandView.circleSize * 0.5
        
        self.baseView.frame = frame
        self.baseView.backgroundColor = .white
        self.baseView.layer.cornerRadius = BrandView.circleSize * 0.5
        self.addSubview(self.baseView)
        
        let labelFrame = CGRect(origin: .zero, size: frame.size)
        self.labelTitle.frame = labelFrame
        self.labelTitle.textColor = .black
        self.labelTitle.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 50)
//        self.labelTitle.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 50)
        self.labelTitle.textAlignment = .center
        self.addSubview(self.labelTitle)
    }
    
    func resetCircleSize() {
//        var frame = self.baseView.frame
//        let circleSize = self.circleScale * BrandView.circleSize
//        frame.size.width = circleScale
//        frame.size.height = circleScale
//        self.baseView.frame = frame
//        self.baseView.layer.cornerRadius = circleSize * 0.5
        self.baseView.transform = CGAffineTransform(scaleX: self.circleScale, y: self.circleScale)
    }
    
    func setData(center: CGPoint, circleScale: CGFloat, title: String! = nil) {
        self.center = center
        self.circleScale = circleScale
        if title != nil {
            self.title = title
        }
    }
}
