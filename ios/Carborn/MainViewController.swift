//
//  MainViewController.swift
//  Carborn
//
//  Created by 이재복 on 2016. 5. 29..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController : UIViewController {
    
    var label = UILabel()
    var currentVersionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Layout
        let viewSize = self.view.bounds.size
        var frame = CGRectZero
        frame.size = viewSize
        
        // System texts
        self.label.frame = frame
        self.label.textAlignment = .Center
        self.label.numberOfLines = 0
        self.view.addSubview(label)
        
        self.setMessage("Checking update...")
        self.checkUpdate()
    }
    
    func setMessage(message: String) {
        
        label.text = message
        
    }
    
    func checkUpdate() {
        
        let storedVersionNumber = NSUserDefaults.standardUserDefaults().integerForKey("VersionNumber")
//        print("storedVersionNumber \(storedVersionNumber)")
        if storedVersionNumber > 0 {
            self.currentVersionNumber = storedVersionNumber
        }
        self.setMessage("Checking update...\nCurrent version is \(self.currentVersionNumber)")
        
        let urlString = "http://slowslipper.woobi.co.kr/api/dummy/slowslipper/carborn/index.json"
        let request = NSURLRequest(URL: NSURL(string: urlString)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: NSTimeInterval(30))
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error -> Void in
            
            if error != nil {
                print("error \(error)")
                return
            }
            
            if let contents = data{
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(contents, options: NSJSONReadingOptions.MutableContainers)
                    let versionNumber = json["versionNumber"] as! Int
                    let apiBaseUrl = json["apiBaseUrl"] as! String
                    if versionNumber > self.currentVersionNumber {
//						print("Update")
						dispatch_async(dispatch_get_main_queue()) {
							self.runUpdate(apiBaseUrl, versionNumber: versionNumber)
						}
                    } else {
//                        print("No update")
						dispatch_async(dispatch_get_main_queue()) {
							self.navigateToCarList()
						}
                    }
                } catch {
                    print("No contents")
                }
            }
        }
        
        task.resume()
        
    }
    
    func runUpdate(baseUrlString: String, versionNumber: Int) {
//        print("Run update for car")
		
        let urlString = (baseUrlString as NSString).stringByAppendingPathComponent("car.json") as String
//        print(urlString)
        self.setMessage("Update car...\n\(urlString)")
        
        let request = NSURLRequest(URL: NSURL(string: urlString)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: NSTimeInterval(30))
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error -> Void in
            
            if error != nil {
                print("error \(error)")
                return
            }
            
            if let contents = data{
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(contents, options: NSJSONReadingOptions.MutableContainers)
                    
                    let config = Realm.Configuration(objectTypes: [Car.self])
                    let realm = try! Realm(configuration: config)
                    let cars = realm.objects(Car)
                    if cars.count > 0 {
                        try! realm.write {
                            realm.delete(cars)
                        }
                    }
                    
                    let results = json["results"] as! [AnyObject]
//                    print(results)
					
                    try! realm.write {
                        for model in results {
                            realm.create(Car.self, value: model)
                        }
                        self.currentVersionNumber = versionNumber
                        NSUserDefaults.standardUserDefaults().setInteger(versionNumber, forKey: "VersionNumber")
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.navigateToCarList()
                    }
                    
                } catch {
                    print("No contents")
                }
            }
        }
        
        task.resume()
    }
    
    func navigateToCarList() {
        
        self.navigationController?.setViewControllers([CarListViewController()], animated: false)
        
    }
    
}
