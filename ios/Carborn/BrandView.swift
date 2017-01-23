//
//  BrandView.swift
//  Carborn
//
//  Created by pureye4u on 23/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit

class BrandView: UIView {
    
    static let defaultWidth: CGFloat = 300
    static let defaultMargin: CGFloat = 20
    
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
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            
            let radius = min(frame.size.width, frame.size.height) * 0.5
            self.layer.cornerRadius = radius
            
            let labelFrame = CGRect(origin: .zero, size: frame.size)
            self.labelTitle.frame = labelFrame
        }
    }
    
    var labelTitle = UILabel()
    
    convenience init() {
        self.init(frame: .zero)
        
        // Initialzie
        self.backgroundColor = .white
        self.labelTitle.textColor = .black
        self.labelTitle.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 50)
        self.labelTitle.textAlignment = .center
        self.addSubview(self.labelTitle)
    }
    
}
