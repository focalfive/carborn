//
//  CategoryNavigationController.swift
//  carborn
//
//  Created by pureye4u on 19/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryNavigationController: UIViewController, CrossNavigationControllerDelegate {
    
    private var _brands: [String]!
    var brands: [String] {
        get {
            if _brands == nil {
                self._brands = []
                let realm = try! Realm()
                
                let cars = realm.objects(Car.self)
                for car in cars {
                    let brand = car.brand
                    if brand.characters.count < 1 {
                        continue
                    }
                    guard let _ = self._brands.index(of: brand) else {
                        self._brands.append(brand)
                        continue
                    }
                }
            }
            return self._brands
        }
    }
    
    private var hPage: Int = 0
    private var hOffset: CGFloat = 0
    private var vPage: Int = 0
    private var vOffset: CGFloat = 0
    
    private var views: [String: BrandView] = [:]
    
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
        self.views["left"] = BrandView()
        self.views["center"] = BrandView()
        self.views["right"] = BrandView()
        
        for (_, view) in self.views {
            self.crossNavigationController.contentView.addSubview(view)
        }
        self.setScroll(hPage: 0, hOffset: 0)
    }
    
    func setScroll(hPage: Int, hOffset: CGFloat, vPage: Int = 0, vOffset: CGFloat = 0) {
        // Brand
        let viewSize = self.view.frame.size
        let width = viewSize.width
        let halfWidth = width * 0.5
        let vRate = max(0, min(vOffset, halfWidth)) / halfWidth
        let scale: CGFloat = 0.7 + 0.3 * vRate
        let dX: CGFloat = width * scale
        let dY: CGFloat = -vRate * (viewSize.height - 100) * 0.5
        var dMoveX: CGFloat = scale * hOffset - dX * CGFloat(hPage)
        var dMoveRateX: CGFloat = abs(2 * dMoveX / dX)
        print("dMoveRateX: \(dMoveRateX)")
        let centerCircleScale: CGFloat = 1 + 0.5 * vRate
        var sideCircleScale: CGFloat = 0.7 + 0.5 * vRate + 0.3 * dMoveRateX
        var position = CGPoint(x: halfWidth - dMoveX, y: viewSize.height * 0.5 + dY)
        var key = ""
        var title = ""
        var i = 0
        
        // Center
        key = "center"
        i = hPage
        title = self.brands[i]
        if let view: BrandView = self.views[key] {
            view.center = position
            view.circleScale = centerCircleScale
            view.title = title
        }
        
        // Left
        position.x -= dX
        key = "left"
        i = (hPage > 0 ? hPage : self.brands.count) - 1
        title = self.brands[i]
        if let view: BrandView = self.views[key] {
            view.center = position
            view.circleScale = sideCircleScale
            view.title = title
        }
        
        // Right
        position.x += dX * 2
        key = "right"
        i = hPage + 1 < self.brands.count ? hPage + 1 : 0
        title = self.brands[i]
        if let view: BrandView = self.views[key] {
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
