//
//  MainViewController.swift
//  carborn
//
//  Created by pureye4u on 16/08/2018.
//  Copyright © 2018 slowslipper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxMoya
import Moya
import SwiftyJSON

class MainViewController: UIViewController {
    
    private lazy var provider = MoyaProvider<CarService>()
    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVersion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadVersion() {
        disposeBag.insert(
            provider.rx.request(.version)
                .subscribe { [weak self] event in
                    switch event {
                    case let .success(response):
//                        print(String(data: response.data, encoding: .utf8))
                        do {
                            let json = try JSON(data: response.data)
                            guard let remoteVersion = json[0]["version"].uInt else {
                                // No remote version
                                return
                            }
                            print("remoteVersion", remoteVersion)
                            if let localVersion = UserDefaults.standard.value(forKey: "version") as? UInt, localVersion == remoteVersion {
                                print("localVersion", localVersion)
                                // Run
                                self?.loadData()
                            }
                            // Update
                            self?.updataCarData(remoteVersion)
                        } catch {
                            print(error)
                        }
                    case let .error(error):
                        print(error)
                    }
            }
        )
    }
    
    func updataCarData(_ version: UInt) {
        disposeBag.insert(
            provider.rx.request(.cars(version: version))
                .subscribe { event in
                    switch event {
                    case let .success(response):
                        do {
                            let json = try JSON(data: response.data)
                            guard let version = json[0]["version"].uInt else {
                                // No version
                                return
                            }
                            print("update version to", version)
                            print("cars count", json[0]["cars"].count)
                        } catch {
                            print(error)
                        }
                    case let .error(error):
                        print(error)
                    }
            }
        )
    }
    
    func loadData() {
        print("loadData")
    }
    
}

