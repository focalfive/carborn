//
//  DetailViewModel.swift
//  carborn
//
//  Created by jud.lee on 2019/11/24.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailViewModelProrocol {
}

class DetailViewModel: NSObject, DetailViewModelProrocol {
    
    convenience init(children: [String: Menu]) {
        self.init()
    }
    
    override init() {
        
    }
    
}
