//
//  CarImageView.swift
//  Carborn
//
//  Created by 이재복 on 2016. 6. 25..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit

class CarImageView : UIView {
    
    private var _imageSize: CGFloat = 100.0
    var imageSize: CGFloat {
        get {
            return self._imageSize
        }
        set {
            self._imageSize = newValue
            self.resize()
        }
    }
    
    private var _borderWidth: CGFloat = 10.0
    var borderWidth: CGFloat {
        get {
            return self._borderWidth
        }
        set {
            self._borderWidth = newValue
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    private var _borderColor: Int = 0x000000
    var borderColor: Int {
        get {
            return self._borderColor
        }
        set {
            self._borderColor = newValue
            self.layer.borderColor = UIColor(netHex: newValue).CGColor
        }
    }
    
    var imageView = UIImageView()
    
    var image = UIImage()
    
    private var _imageUrl: String?
    var imageUrl: String? {
        get {
            return self._imageUrl
        }
        set {
            self._imageUrl = newValue
            if let imageUrl = newValue {
                self.loadImage(imageUrl)
            } else {
                self.unloadImage()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // Initialize
        
        var imageFrame = CGRectZero
        imageFrame.size = frame.size
        self.imageView.frame = imageFrame
        self.clipsToBounds = true
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(imageUrl: String) {
//        print("loadImage", imageUrl)
        let url = NSURL(string: imageUrl)
        if let imageData = NSData(contentsOfURL: url!) {
            let image = UIImage(data: imageData)
//            print(image!.size)
            self.imageView.image = image
            self.addSubview(self.imageView)
            self.resize()
        }
    }
    
    func unloadImage() {
        // TODO: Change to "No image"
        self.imageView.image = nil
    }
    
    func resize() {
        self.layer.cornerRadius = self.imageSize * 0.5
        
        if let imageSize = self.imageView.image?.size {
            var frame = CGRectZero
            let isSquare = imageSize.width == imageSize.height
            if isSquare {
                frame.size.width = self.imageSize
                frame.size.height = self.imageSize
            } else {
                let isWide = imageSize.width > imageSize.height
                // Fit
                let rate = self.imageSize / (isWide ? imageSize.width : imageSize.height)
                let imageWidth = isWide ? self.imageSize : imageSize.width * rate
                let imageHeight = isWide ? imageSize.height * rate : self.imageSize
                if isWide {
                    frame.origin.y = (self.imageSize - imageHeight) * 0.5
                } else {
                    frame.origin.x = (self.imageSize - imageWidth) * 0.5
                }
                // Fill
//                let rate = self.imageSize / (isWide ? imageSize.height : imageSize.width)
//                let imageWidth = isWide ? imageSize.width * rate : self.imageSize
//                let imageHeight = isWide ? self.imageSize : imageSize.height * rate
//                if isWide {
//                    frame.origin.x = (self.imageSize - imageWidth) * 0.5
//                } else {
//                    frame.origin.y = (self.imageSize - imageHeight) * 0.5
//                }
                
                frame.size.width = imageWidth
                frame.size.height = imageHeight
            }
//            print(frame)
            self.imageView.frame = frame
        }
    }
    
}
