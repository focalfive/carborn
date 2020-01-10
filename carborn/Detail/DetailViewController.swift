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
            bindViewModel()
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
        
        view.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
        label.numberOfLines = 0
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().inset(20)
        }
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard isViewLoaded else {
            return
        }
        guard let viewModel = viewModel else {
            return
        }
        viewModel.detailModel.subscribe(onNext: { [unowned self] model in
            debugPrint("subscribed model", model)
            guard let model = model else {
                self.label.text = "Error"
                return
            }
            let string = model.brand + "\n"
                + model.displayName + "\n"
                + model.generationName
            debugPrint("string", string)
            self.label.text = string
        }).disposed(by: disposeBag)
    }
    
}
