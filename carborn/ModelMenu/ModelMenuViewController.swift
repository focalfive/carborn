//
//  ModelMenuViewController.swift
//  carborn
//
//  Created by jud.lee on 2019/11/13.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ModelMenuViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var tableView = UITableView()
    
    var viewModel: ModelMenuViewModel? {
        didSet {
            print("viewModel did set")
            if isViewLoaded {
                self.bindMenuViewModel()
            }
            self.viewModel?.load()
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
        
        tableView.register(ModelMenuTableViewCell.self, forCellReuseIdentifier: ModelMenuTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.center.size.equalToSuperview()
        }
        
        bindMenuViewModel()
    }
    
    private func bindMenuViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.collection.bind(to: tableView.rx.items(cellIdentifier: ModelMenuTableViewCell.identifier, cellType: ModelMenuTableViewCell.self)) { (index: Int, element: ModelMenu, cell: ModelMenuTableViewCell) in
            cell.textLabel?.text = element.name
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ModelMenu.self)
            .subscribe(onNext: { model in
                print(model.name)
            })
            .disposed(by: disposeBag)
    }
    
}

extension ModelMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
