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
                        let maxVer = Version(string: data["max_app_ver"] as? String)
                        print(data)
                        print(minVer.string)
                        print(appVer.string)
                        print(maxVer.string)
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            print(error)
        })
    }
    
    func startMain() {
        self.navigationController?.viewControllers = [MainViewController()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
