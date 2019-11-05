//
//  MenuViewController.swift
//  carborn
//
//  Created by jud.lee on 2019/11/04.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit
import RxSwift

class MenuViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    var viewModel: MenuViewModel? {
        didSet {
            print("viewModel did set")
            self.viewModel?.load()
            self.viewModel?.menuCollection.subscribe(onNext: { collection in
                debugPrint(collection)
            }, onError: { error in
                debugPrint(error.localizedDescription)
            }, onCompleted: {
                debugPrint("MenuViewModel menuCollection completed")
            }, onDisposed: {
                debugPrint("MenuViewModel menuCollection disposed")
            }).disposed(by: disposeBag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
