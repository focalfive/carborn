//
//  DetailViewController.swift
//  carborn
//
//  Created by jud.lee on 2019/11/24.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class DetailViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let label = UILabel()
    
    var viewModel: DetailViewModel? {
        didSet {
            print("viewModel did set")
            if isViewLoaded {
                bindViewModel()
            }
        }
    }
    var id: String? {
        didSet {
            label.text = id
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
        
        label.textColor = .white
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.size.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        
    }
}
