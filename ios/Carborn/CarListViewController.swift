//
//  ViewController.swift
//  Carborn
//
//  Created by 이재복 on 2016. 5. 29..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class CarListViewController: UIViewController, UIScrollViewDelegate {
    
    var makerSize = CGSizeMake(100, 100)
    var carSize = CGSizeMake(300, 300)
    let makerListView = UIScrollView()
    let carListView = UIScrollView()
	let dbResults: Results<Car> = try! Realm().objects(Car).sorted("maker", ascending: true)
    var collection: Dictionary<String, [Car]> = Dictionary<String, [Car]>()
    var currentSectionIndex = 0
    var currentIndex = 0
    var makerListScrolling = false
    var carListScrolling = false
    
    var viewSize: CGSize {
        get {
            return self.view.bounds.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        for model in self.dbResults {
            let maker = model.maker
            if self.collection.keys.indexOf(maker) == nil {
				self.collection[maker] = [Car]()
            }
            self.collection[maker]!.append(model)
        }
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let viewSize = self.viewSize
        self.makerSize.width = viewSize.width
        var frame = CGRectZero
        let headerHeight = UIApplication.sharedApplication().statusBarFrame.size.height + self.navigationController!.navigationBar.bounds.size.height
        
        // Maker list
        frame.origin.x = (viewSize.width - self.makerSize.width) * 0.5
        frame.origin.y = headerHeight
        frame.size.width = self.makerSize.width
        frame.size.height = self.makerSize.height
        
        self.makerListView.frame = frame
        self.makerListView.pagingEnabled = true
        self.makerListView.showsVerticalScrollIndicator = false
        self.makerListView.showsHorizontalScrollIndicator = false
//        self.makerListView.backgroundColor = UIColor.redColor()
        self.makerListView.delegate = self
        self.view.addSubview(self.makerListView)
        
        // Car list
        frame.origin.x = (viewSize.width - self.carSize.width) * 0.5
        frame.origin.y += frame.size.height
        frame.size.width = self.carSize.width
//        frame.size.width = viewSize.width
        frame.size.height = self.carSize.height
        
        self.carListView.frame = frame
        self.carListView.clipsToBounds = false
        self.carListView.pagingEnabled = true
        self.carListView.showsVerticalScrollIndicator = false
        self.carListView.showsHorizontalScrollIndicator = false
//        self.carListView.backgroundColor = UIColor.blueColor()
        self.carListView.delegate = self
        self.view.addSubview(self.carListView)
        
        self.initData()
    }
    
    func initData() {
        initMakerData()
        initCarData()
    }
    
    func initMakerData() {
        var contentWidth = CGFloat(0)
        for makerName in self.collection.keys {
            let makerLabel = UILabel(frame: CGRectMake(contentWidth, 0, self.makerSize.width, self.makerSize.height))
            makerLabel.textAlignment = .Center
            makerLabel.text = makerName.uppercaseString
            makerLabel.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 48)
            self.makerListView.addSubview(makerLabel)
            contentWidth += self.makerSize.width
        }
        
        self.makerListView.contentSize = CGSizeMake(contentWidth, self.makerSize.height)
    }
    
    func initCarData() {
//        let viewSize = self.viewSize
//        var contentWidth = CGFloat(viewSize.width - self.carSize.width) * 0.5
        var contentWidth = CGFloat(0)
        for (_, cars) in self.collection {
            for car in cars {
                let carItemView = CarItemView(frame: CGRectMake(contentWidth, 0, self.carSize.width, self.carSize.height))
                carItemView.data = car
                carItemView.userInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                carItemView.addGestureRecognizer(tapGesture)
                self.carListView.addSubview(carItemView)
                contentWidth += self.carSize.width
            }
        }
        
        self.carListView.contentSize = CGSizeMake(contentWidth, self.carSize.height)
    }
    
    func handleTap(sender:UIGestureRecognizer) {
        guard let carItemView = sender.view as? CarItemView else {
            return
        }
        
        print("handleTap", carItemView.data.model)
        let detailViewController = CarDetailViewController()
        detailViewController.model = carItemView.data
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func getSectionIndex(index: Int) -> Int {
        var length = 0
        var sectionIndex = 0
        for (_, model) in self.collection {
            length += model.count
            if index < length {
                return sectionIndex
            }
            sectionIndex += 1
        }
        return -1
    }
    
    func getIndex(sectionIndex: Int, isNext: Bool = true) -> Int {
        var length = 0
        var index = 0
        for (_, model) in self.collection {
            if index == sectionIndex {
                if isNext {
                    return length
                } else {
                    return length + model.count - 1
                }
            }
            length += model.count
            index += 1
        }
        return 0
    }
    
    func scrollSectionPage(index: Int) {
        let x = CGFloat(index) * self.makerSize.width
        self.makerListView.setContentOffset(CGPointMake(x, 0.0), animated: true)
    }
    
    func scrollPage(index: Int) {
        let x = CGFloat(index) * self.carSize.width
        self.carListView.setContentOffset(CGPointMake(x, 0.0), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.isEqual(self.makerListView) {
            self.makerListScrolling = true
            self.carListScrolling = false
        } else if scrollView.isEqual(self.carListView) {
            self.carListScrolling = true
            self.makerListScrolling = false
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.makerListScrolling = false
            self.carListScrolling = false
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.makerListScrolling = false
        self.carListScrolling = false
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.makerListScrolling && scrollView.isEqual(self.makerListView) {
            let sectionIndex = Int(scrollView.contentOffset.x / self.makerSize.width)
            if sectionIndex != self.currentSectionIndex {
//                print("Set section index from", self.currentSectionIndex, sectionIndex)
                let isNext = self.currentSectionIndex < sectionIndex
                self.currentSectionIndex = sectionIndex
                let index = self.getIndex(sectionIndex, isNext: isNext)
                if index != self.currentIndex {
//                    print("Set index from", self.currentIndex, index, "at section scroll")
                    self.currentIndex = index
                    self.scrollPage(index)
                }
            }
        } else if self.carListScrolling && scrollView.isEqual(self.carListView) {
            let index = Int(round(scrollView.contentOffset.x / self.carSize.width))
            if index != self.currentIndex {
//                print("Set index from", self.currentIndex, index)
                self.currentIndex = index
                let sectionIndex = self.getSectionIndex(index)
                if sectionIndex != self.currentSectionIndex {
//                    print("Set section index from", self.currentSectionIndex, sectionIndex, "at scroll")
                    self.currentSectionIndex = sectionIndex
                    self.scrollSectionPage(sectionIndex)
                }
            }
        }
    }

}

