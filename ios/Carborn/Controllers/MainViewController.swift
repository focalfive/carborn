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
import ObjectMapper
import RealmSwift

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
                            let localVersion = UserDefaults.standard.integer(forKey: "dataVersion")
                            guard localVersion < remoteVersion else {
                                print("localVersion", localVersion)
                                // Run
                                self?.loadData()
                                return
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
                            guard json.count > 0 else {
                                // No node
                                return
                            }
                            let item = json[0]
                            guard let version = item["version"].int else {
                                // No version
                                return
                            }
                            let currentVersion = UserDefaults.standard.integer(forKey: "dataVersion")
                            guard currentVersion < version else {
                                print("Current version(\(currentVersion)) is latest version : \(version)")
                                return
                            }
                            print("update version to", version)
                            let cars = item["cars"]
                            print("cars count", cars.count)
                            guard cars.count > 0 else {
                                // No cars
                                return
                            }
                            let collection: [CarModel] = cars.compactMap {
//                                print($0.1.rawValue)
                                if let string = $0.1.rawString() {
                                    return CarModel(JSONString: string)
                                } else {
                                    print("$0.1.rawString() is nil")
                                }
                                return nil
                            }
                            if collection.count > 0 {
                                let realm = try! Realm()
                                try! realm.write {
                                    realm.add(collection)
                                    UserDefaults.standard.set(version, forKey: "dataVersion")
                                }
                            }
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

