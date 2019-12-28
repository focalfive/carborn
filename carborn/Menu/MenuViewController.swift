//
//  MenuViewController.swift
//  carborn
//
//  Created by jud.lee on 2019/11/04.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MenuViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var tableView = UITableView()
    
    var viewModel: MenuViewModel? {
        didSet {
            print("viewModel did set")
            if isViewLoaded {
                self.bindMenuViewModel()
            }
            
            if let viewModel = viewModel, !viewModel.hasCollection {
                viewModel.load()
            }
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
        
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
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
        
        viewModel.menuCollection.bind(to: tableView.rx.items(cellIdentifier: MenuTableViewCell.identifier, cellType: MenuTableViewCell.self)) { (index: Int, element: Menu, cell: MenuTableViewCell) in
            cell.textLabel?.text = element.name
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Menu.self)
            .subscribe(onNext: { model in
                print(model.name)
                
//                self.navigateToSubMenu(id: model.id)
                if let id = model.id {
                    self.navigateToDetail(id: id)
                    return
                }
                
                if let children = model.children {
                    self.navigateToSubMenu(children: children)
                    return
                }
            })
            .disposed(by: disposeBag)
    }
    
//    private func navigateToSubMenu(id: String) {
//        guard let navigation = navigationController else {
//            return
//        }
//        let controller = BrandMenuViewController()
//        controller.viewModel = BrandMenuViewModel(id: id)
//        navigation.pushViewController(controller, animated: true)
//    }
    private func navigateToSubMenu(children: [String: Menu]) {
        print("navigateToSubMenu", children)
        guard let navigation = navigationController else {
            return
        }
        let controller = MenuViewController()
        controller.viewModel = MenuViewModel(children: children)
        navigation.pushViewController(controller, animated: true)
    }
    
    private func navigateToDetail(id: String) {
        print("navigateToDetail", id)
        guard let navigation = navigationController else {
            return
        }
        let controller = DetailViewController()
        let viewModel = DetailViewModel(id: id)
        controller.viewModel = viewModel
        viewModel.load()
        navigation.pushViewController(controller, animated: true)
    }
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
