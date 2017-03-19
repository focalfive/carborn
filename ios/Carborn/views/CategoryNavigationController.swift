//
//  CategoryNavigationController.swift
//  carborn
//
//  Created by pureye4u on 19/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit

enum Direction {
    case vertical
    case horizontal
}

prefix func !(direction: Direction) -> Direction {
    return direction == .vertical ? .horizontal : .vertical
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
                self.setSelection(direction: .horizontal, page: newValue)
                self._hPage = newValue
            }
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
                self._vPage = newValue
                self.setSelection(direction: .vertical, page: newValue)
            }
        }
    }
    private var vOffset: CGFloat = 0
    private var _direction: Direction = .horizontal
    private var direction: Direction {
        get {
            return self._direction
        }
    }
    
    let limitDepth = 4
    
    private var brandViews: [String: BrandView] = [:]
    
    private var crossNavigationController = CrossNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crossNavigationController.horizontalPageLimit = self.brands.count
        self.crossNavigationController.verticalPageLimit = 1
        self.crossNavigationController.useVerticalPageRevers = false
        self.crossNavigationController.view.backgroundColor = .black
        self.crossNavigationController.delegate = self
        self.view.addSubview(self.crossNavigationController.view)
        
        self.initView()
    }
    
    func initView() {
        self.brandViews["left"] = BrandView()
        self.brandViews["center"] = BrandView()
        self.brandViews["right"] = BrandView()
        
        for (_, view) in self.brandViews {
            self.crossNavigationController.contentView.addSubview(view)
        }
        self.setScroll(hPage: 0, hOffset: 0)
        self.syncData()
    }
    
    func setScroll(hPage: Int, hOffset: CGFloat, vPage: Int = 0, vOffset: CGFloat = 0) {
        let depth = self.selection.count
//        print("vp: \(vPage), vo: \(vOffset)")
        
        // Brand
        let viewSize = self.view.frame.size
        let width = viewSize.width
        let height = viewSize.height
        let halfWidth = width * 0.5
        let vRate = depth < 3 ? max(0, min(vOffset, height)) / height : 1.0
        let vRateABS = depth < 3 ? max(0, min(abs(vOffset), height)) / height : 1.0
        let scale: CGFloat = 0.7 + 0.3 * vRate
        let dX: CGFloat = width * scale
        let dY: CGFloat = -vRate * (viewSize.height - 100) * 0.5
        let dMoveX: CGFloat = scale * hOffset - dX * CGFloat(hPage)
        let dMoveRateX: CGFloat = abs(2 * dMoveX / dX)
        let centerCircleScale: CGFloat = 1 + 0.5 * vRateABS
        let sideCircleScale: CGFloat = 0.7 + 0.5 * vRate + 0.3 * dMoveRateX
        var position = CGPoint(x: halfWidth, y: viewSize.height * 0.5)
        var key = ""
        var title: String!
        var i = 0
        
        // Center
        i = hPage
        if depth == 1 {
            position.x -= dMoveX
            title = self.brands[i]
        }
        position.y += dY
        key = "center"
        if let view: BrandView = self.brandViews[key] {
            view.setData(center: position, circleScale: centerCircleScale, title: title)
        }
        
        // Left
        position.x -= dX
        key = "left"
        i = (hPage > 0 ? hPage : self.brands.count) - 1
        if depth == 1 {
            title = self.brands[i]
        }
        if let view: BrandView = self.brandViews[key] {
            view.setData(center: position, circleScale: sideCircleScale, title: title)
        }
        
        // Right
        position.x += dX * 2
        key = "right"
        i = hPage + 1 < self.brands.count ? hPage + 1 : 0
        if depth == 1 {
            title = self.brands[i]
        }
        if let view: BrandView = self.brandViews[key] {
            view.setData(center: position, circleScale: sideCircleScale, title: title)
        }
    }
    
    func setSelection(direction: Direction, page: Int) {
        let count = self.selection.count
        let index = count - 1
        if self.direction == direction {
            if count > 1, page == 0 {
                self.popSelection()
            } else {
                self.selection[index] = page
                self.syncData()
            }
        } else {
            if count < self.limitDepth {
                self._direction = direction
                self.pushSelection(page: 1)
            }
        }
//        print("Selection: \(self.selection)")
    }
    
    func pushSelection(page: Int) {
        self.selection.append(page)
        switch self.direction {
        case .horizontal:
            self.crossNavigationController.horizontalPage = page
            self.crossNavigationController.useHorizontalPageRevers = false
        case .vertical:
            self.crossNavigationController.verticalPage = page
        }
        self.syncData()
    }
    
    func popSelection() {
        self.selection.removeLast()
        self._direction = !self.direction
        guard let page = self.selection.last else {
            return
        }
        self.syncData()
        switch self.direction {
        case .horizontal:
//            print("reset h page to \(page) hOffset: \(self.hOffset)")
            self.crossNavigationController.horizontalPage = page
            if self.selection.count == 1 {
                self.crossNavigationController.useHorizontalPageRevers = true
            }
        case .vertical:
//            print("reset v page to \(page) vOffset: \(self.vOffset)")
            self.crossNavigationController.verticalPage = page
        }
    }
    
    func syncData() {
        let depth = self.selection.count
        if depth < 1 {
            return
        }
        
        var hPages = 1
        var vPages = 1
        
        // By depth
        
        // 1. brand
        var index = self.selection[0]
        let brand = self.brands[index]
        let models = Car.modelNames(brand)
        
        if depth == 1 {
            print("Brand \(index): \(brand)")
            hPages = self.brands.count
            vPages = models.count + 1
        } else {
            index = self.selection[1] - 1
            let model = models[index]
            let cars = Car.cars(brand)
            
            if depth == 2 {
                print("Model \(index): \(model)")
                hPages = cars.count
                vPages = models.count + 1
            } else {
                index = self.selection[2] - 1
                let car = cars[index]
                print("Car \(index): \(car.display_name)")
                hPages = cars.count
                vPages = models.count + 1
            }
        }
        self.crossNavigationController.verticalPageLimit = vPages
        self.crossNavigationController.horizontalPageLimit = hPages
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
