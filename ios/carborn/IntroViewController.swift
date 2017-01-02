//
//  IntroViewController.swift
//  carborn
//
//  Created by pureye4u on 27/12/2016.
//  Copyright © 2016 slowslipper. All rights reserved.
//

import UIKit
import AFNetworking

class IntroViewController: UIViewController {
    
    let versionUrl = "http://tendersolid.com/carborn/status/"
    let databaseUrl = "https://api.mlab.com/api/1/databases/carborn/collections/cars/"
    let databaseApiKey = "RVBlmzNJ6hMYAruIrDZtDfhUaKGKbbvQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Initialize view
        let frame = self.view.bounds
        let label = UILabel(frame: frame)
        label.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 100)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Intro"
        self.view.addSubview(label)
        
        self.loadAppEnv()
    }
    
    func loadAppEnv() {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(self.versionUrl,
                    parameters: nil,
                    progress: nil,
                    success: {(task, responseObject) -> Void in
                        let data = responseObject as! [String : Any?]
                        let appVer = AppInfo.sharedInstance.version
                        let minVer = Version(string: data["min_app_ver"] as? String)
                        let maxVer: Version!
                        if let temp = data["max_app_ver"] as? String {
                            maxVer = Version(string: temp)
                        } else {
                            maxVer = Version.maxValue
                        }
                        print(data)
                        print(minVer.string)
                        print(appVer.string)
                        print(maxVer.string)
                        print(maxVer.number)
                        if minVer <= appVer && appVer <= maxVer {
                            print("Version is in range")
                            if let objId = data["db_obj_id"] as? String {
                                self.loadDatabase(id: objId)
                            } else {
                                self.showAlert(title: "Error", message: "Obj id not found.")
                            }
                        } else {
                            self.showAlert(title: "Error", message: "This app is not in range of enabel version.")
                        }
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            print(error)
        })
    }
    
    func startMain() {
        self.navigationController?.viewControllers = [MainViewController()]
    }
    
    func loadDatabase(id: String) {
        let url = "\(self.databaseUrl)\(id)?apiKey=\(self.databaseApiKey)"
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(url,
                    parameters: nil,
                    progress: nil,
                    success: {(task, responseObject) -> Void in
                        let data = responseObject as! [String : Any?]
                        print(data)
                        if let cars = data["cars"] as? [[String: Any?]] {
                            self.initDatabase(list: cars)
                        } else {
                            self.showAlert(title: "Error", message: "Database error.")
                        }
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            print(error)
        })
    }
    
    func showAlert(title: String, message: String) {
        // TODO: popup retry or get data for this version automatically
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func initDatabase(list: [[String: Any]]) {
        print("init database", list)
        self.startMain()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
