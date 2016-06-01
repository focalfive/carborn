//
//  ViewController.swift
//  Carborn
//
//  Created by 이재복 on 2016. 5. 29..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class CarListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let listView = UITableView()
	let dbResults: Results<Car> = try! Realm().objects(Car).sorted("maker", ascending: true)
    var collection: Dictionary<String, [Car]> = Dictionary<String, [Car]>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for model in self.dbResults {
            let maker = model.maker
            if self.collection.keys.indexOf(maker) == nil {
				self.collection[maker] = [Car]()
//				print(maker)
            }
            self.collection[maker]!.append(model)
        }
        
        self.listView.dataSource = self
        self.listView.delegate = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let viewSize = self.view.bounds.size
        var frame = CGRectZero
        frame.size = viewSize
        
        self.listView.frame = frame
        self.view.addSubview(self.listView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.collection.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = Array(self.collection.keys).sort(<)[section]
        return self.collection[key]!.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let key = Array(self.collection.keys).sort(<)[section]
        return key
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let key = Array(self.collection.keys).sort(<)[indexPath.section]
        let model = self.collection[key]![indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel!.text = model.model
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("Select", indexPath.section, indexPath.row)
		
		let key = Array(self.collection.keys).sort(<)[indexPath.section]
		let model = self.collection[key]![indexPath.row]
		
		let detailViewController = CarDetailViewController()
		detailViewController.model = model
		
		self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

