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
    var carSize = CGSizeMake(100, 100)
    let makerListView = UIScrollView()
    let carListView = UIScrollView()
	let dbResults: Results<Car> = try! Realm().objects(Car).sorted("maker", ascending: true)
    var collection: Dictionary<String, [Car]> = Dictionary<String, [Car]>()

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
        
        let viewSize = self.view.bounds.size
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
        self.makerListView.delegate = self
        self.view.addSubview(self.makerListView)
        
        // Car list
//        frame.origin.x = (viewSize.width - self.carSize.width) * 0.5
        frame.origin.y += 20
//        frame.size.width = self.carSize.width
        frame.size.width = viewSize.width
        frame.size.height = self.carSize.height
        
        self.carListView.frame = frame
//        self.carListView.pagingEnabled = true
        self.carListView.showsVerticalScrollIndicator = false
        self.carListView.showsHorizontalScrollIndicator = false
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
            makerLabel.text = makerName
            self.makerListView.addSubview(makerLabel)
            contentWidth += self.makerSize.width
        }
        
        self.makerListView.contentSize = CGSizeMake(contentWidth, self.makerSize.height)
    }
    
    func initCarData() {
        var contentWidth = CGFloat(0)
        for (_, cars) in self.collection {
            for car in cars {
                let carLabel = UILabel(frame: CGRectMake(contentWidth, 0, self.carSize.width, self.carSize.height))
                carLabel.textAlignment = .Center
                carLabel.text = car.model
                self.carListView.addSubview(carLabel)
                contentWidth += self.carSize.width
            }
        }
        
        self.makerListView.contentSize = CGSizeMake(contentWidth, self.carSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scroll", scrollView.contentOffset)
    }

}

