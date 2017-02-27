//
//  CategoryNavigationController.swift
//  carborn
//
//  Created by pureye4u on 19/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

enum Direction {
    case vertical
    case horizontal
}

class CategoryNavigationController: UIViewController, CrossNavigationControllerDelegate {
    
    private var selection: [Int] = [0]
    private var _brands: [String]!
    var brands: [String] {
        get {
            if _brands == nil {
                self._brands = Car.brandNames()
            }
            return self._brands
        }
    }
    
    private var _hPage: Int = 0
    private var hPage: Int {
        get {
            return self._hPage
        }
        set {
            if self._hPage != newValue {
                let count = self.selection.count
                let index = count - 1
                if self.direction == .horizontal {
                    if count > 1, newValue == 0 {
                        self.selection.removeLast()
                    } else {
                        self.selection[index] = newValue
                    }
                } else {
                    self.selection.append(newValue)
                }
                self._hPage = newValue
                self._direction = .horizontal
            }
            print("Selection: \(self.selection)")
        }
    }
    private var hOffset: CGFloat = 0
    private var _vPage: Int = 0
    private var vPage: Int {
        get {
            return self._vPage
        }
        set {
            if self._vPage != newValue {
                let count = self.selection.count
                let index = count - 1
                if self.direction == .vertical {
                    if newValue == 0 {
                        self.selection.removeLast()
                        if count == 2 {
                            self.crossNavigationController.useHorizontalPageRevers = true
                        }
                    } else {
                        self.selection[index] = newValue
                    }
                } else {
                    if count == 1 {
                        self.crossNavigationController.useHorizontalPageRevers = false
                    }
                    self.selection.append(newValue)
                }
                self._vPage = newValue
                self._direction = .vertical
            }
            print("Selection: \(self.selection)")
        }
    }
    private var vOffset: CGFloat = 0
    private var _direction: Direction = .horizontal
    private var direction: Direction {
        get {
            return self._direction
        }
    }
    
    private var brandViews: [String: BrandView] = [:]
    
    private var crossNavigationController = CrossNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        
        self.crossNavigationController.horizontalPageLimit = self.brands.count
        self.crossNavigationController.verticalPageLimit = 5
        self.crossNavigationController.useVerticalPageRevers = false
        self.crossNavigationController.view.backgroundColor = .black
        self.crossNavigationController.delegate = self
        self.view.addSubview(self.crossNavigationController.view)
    }
    
    func initView() {
//        var frame = CGRect(origin: .zero, size: CGSize(width: BrandView.circleSize, height: BrandView.circleSize))
        self.brandViews["left"] = BrandView()
        self.brandViews["center"] = BrandView()
        self.brandViews["right"] = BrandView()
        
        for (_, view) in self.brandViews {
            self.crossNavigationController.contentView.addSubview(view)
        }
        self.setScroll(hPage: 0, hOffset: 0)
    }
    
    func setScroll(hPage: Int, hOffset: CGFloat, vPage: Int = 0, vOffset: CGFloat = 0) {
        // Brand
        let viewSize = self.view.frame.size
        let width = viewSize.width
        let height = viewSize.height
        let halfWidth = width * 0.5
//        let vRate = max(0, min(vOffset, halfWidth)) / halfWidth
        let vRate = max(0, min(vOffset, height)) / height
        let vRateABS = max(0, min(abs(vOffset), height)) / height
        let scale: CGFloat = 0.7 + 0.3 * vRate
        let dX: CGFloat = width * scale
        let dY: CGFloat = -vRate * (viewSize.height - 100) * 0.5
        let dMoveX: CGFloat = scale * hOffset - dX * CGFloat(hPage)
        let dMoveRateX: CGFloat = abs(2 * dMoveX / dX)
        let centerCircleScale: CGFloat = 1 + 0.5 * vRateABS
        let sideCircleScale: CGFloat = 0.7 + 0.5 * vRate + 0.3 * dMoveRateX
        var position = CGPoint(x: halfWidth - dMoveX, y: viewSize.height * 0.5 + dY)
        var key = ""
        var title = ""
        var i = 0
//        print("dMoveRateX: \(dMoveRateX)")
        
        // Center
        key = "center"
        i = hPage
        title = self.brands[i]
//        print(title)
        if let view: BrandView = self.brandViews[key] {
            view.center = position
            view.circleScale = centerCircleScale
            view.title = title
        }
        
        // Left
        position.x -= dX
        key = "left"
        i = (hPage > 0 ? hPage : self.brands.count) - 1
        title = self.brands[i]
        if let view: BrandView = self.brandViews[key] {
            view.center = position
            view.circleScale = sideCircleScale
            view.title = title
        }
        
        // Right
        position.x += dX * 2
        key = "right"
        i = hPage + 1 < self.brands.count ? hPage + 1 : 0
        title = self.brands[i]
        if let view: BrandView = self.brandViews[key] {
            view.center = position
            view.circleScale = sideCircleScale
            view.title = title
        }
    }
    
    func navigationDidScrollToVertical(page: Int, offset: CGFloat) {
//        print("vertical \(page) \(offset)")
        self.vPage = page
        self.vOffset = offset
        self.setScroll(hPage: self.hPage, hOffset: self.hOffset, vPage: page, vOffset: offset)
    }
    
    func navigationDidScrollToHorizontal(page: Int, offset: CGFloat) {
//        print("horizontal \(page) \(offset)")
        self.hPage = page
        self.hOffset = offset
        self.setScroll(hPage: page, hOffset: offset, vPage: self.vPage, vOffset: self.vOffset)
    }
}
