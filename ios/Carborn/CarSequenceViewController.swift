//
//  CarSequenceViewController.swift
//  Carborn
//
//  Created by 이재복 on 2016. 7. 3..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class CarSequenceViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var spec = ""
    let listView = UITableView()
    var dbResults: Results<Car>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.spec == "" {
            return
        }
        
        print("Spec: \(self.spec)")
        
        self.dbResults = try! Realm().objects(Car).sorted(self.spec, ascending: true)
        
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dbResults.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = self.dbResults[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(model[self.spec] as! Int) : \(model.model)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        print("Select", indexPath.section, indexPath.row)
        
        let model = self.dbResults[indexPath.row]
        
        let detailViewController = CarDetailViewController()
        detailViewController.model = model
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}