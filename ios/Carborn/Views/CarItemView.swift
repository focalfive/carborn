//
//  CarItemView.swift
//  Carborn
//
//  Created by Jud Lee on 2016. 8. 25..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit

class CarItemView : UIView {
    
    var titleLabel = UILabel()
    var imageView = UIView()
    var _data: Car!
    var data: Car {
        get {
            return self._data
        }
        set(newValue) {
            if self._data != newValue {
                self._data = newValue
                self.titleLabel.text = newValue.model
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // Initialize
        
        // Label
        var labelFrame = CGRectZero
        labelFrame.size.width = frame.size.width
        labelFrame.size.height = 30
        labelFrame.origin.y = frame.size.height - labelFrame.size.height
        
        self.titleLabel.textAlignment = .Center
        self.titleLabel.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 24)
        self.titleLabel.frame = labelFrame
        
        self.addSubview(self.titleLabel)
        
        // Image
        var imageFrame = CGRectZero
        let imageWidth = labelFrame.origin.y - 10
        imageFrame.size.width = imageWidth
        imageFrame.size.height = imageWidth
        imageFrame.origin.x = (frame.size.width - imageWidth) * 0.5
        
        self.imageView.frame = imageFrame
        self.imageView.layer.cornerRadius = imageWidth * 0.5
        self.imageView.backgroundColor = UIColor.lightGrayColor()
        
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
