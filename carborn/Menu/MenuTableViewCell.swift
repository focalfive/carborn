//
//  MenuTableViewCell.swift
//  carborn
//
//  Created by pureye4u on 2019/11/07.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let identifier = "MenuTableViewCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        if let label = textLabel {
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 50, weight: .ultraLight)
            label.lineBreakMode = .byClipping
        }
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: MenuTableViewCell.identifier)
    }
    
}
