//
//  ViewController.swift
//  carborn
//
//  Created by pureye4u on 29/07/2018.
//  Copyright © 2018 slowslipper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let provider = MoyaProvider<CarService>()
        provider.request(.brands) { result in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

