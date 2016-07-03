//
//  CarDetailViewController.swift
//  Carborn
//
//  Created by 이재복 on 2016. 5. 29..
//  Copyright © 2016년 slowslipper. All rights reserved.
//

import UIKit

enum Tag: Int {
    case EngineHP = 1
    case EngineTorque = 2
    case Weight = 3
    case EfficiencyEconomy = 4
    case EfficiencySport = 5
}

class CarDetailViewController : UIViewController {
    
    var model: Car = Car()
    var specContainer = UIView()
    var specPositionY = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let viewSize = self.view.bounds.size
        var frame = CGRectZero
        frame.origin.y = 80//self.navigationController!.navigationBar.frame.size.height
        
//        print("viewDidLoad", model)
        
        // Main image
        let imageMargin: CGFloat = 100.0
        let imageSize: CGFloat = viewSize.width - imageMargin * 2.0
        let imageUrl = model.mainImage
        frame.origin.x = imageMargin
        frame.size.width = imageSize
        frame.size.height = imageSize
        let imageView = CarImageView(frame: frame)
        imageView.borderWidth = 5
        imageView.borderColor = 0x57B196
        imageView.imageSize = imageSize
        imageView.imageUrl = imageUrl
        
        self.view.addSubview(imageView)
        
        // Title
        frame.origin.x = 0.0
        frame.origin.y += frame.size.height + 20
        frame.size.width = viewSize.width
        frame.size.height = 20
        let labelTitle = UILabel(frame: frame)
        labelTitle.text = "\(model.maker) \(model.model)"
        labelTitle.textAlignment = .Center
        self.view.addSubview(labelTitle)
        
        // Sepc
        let specMargin: CGFloat = 10.0
        let specWidth = viewSize.width - specMargin * 2.0
        frame.origin.x = specMargin
        frame.origin.y += frame.size.height + 20
        frame.size.width = specWidth
        frame.size.height = 20
        let labelSpecTitle = UILabel(frame: frame)
        labelSpecTitle.text = "Spec"
        self.view.addSubview(labelSpecTitle)
        
        // Spec container
        frame.origin.x = specMargin
        frame.origin.y += frame.size.height + 10
        frame.size.height = viewSize.height - frame.origin.y
        frame.size.width = specWidth
        self.specContainer.frame = frame
//        self.specContainer.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.specContainer)
        
        // Sepc detail
        var engineValue = "\(model.cylinderArrangement)\(model.cylinders) \(model.displacement)cc"
        if model.maxRPM > 0 {
            engineValue = engineValue.stringByAppendingString(" (max \(model.maxRPM)rpm)")
        }
        
        self.addDataList(title: "엔진", value: engineValue)
        
        if model.engineLayout == "longitudinal" {
            self.addDataList(title: "레이아웃", value: "세로배치", indent: 20)
        } else if model.engineLayout == "transverse" {
            self.addDataList(title: "레이아웃", value: "가로배치", indent: 20)
        }
        
        var engineHP = "\(model.hp)마력"
        if model.hpAtRPM > 0 {
            engineHP = engineHP.stringByAppendingString(" (\(model.hpAtRPM)rpm)")
        }
        self.addDataList(title: "출력", value: engineHP, forButtonTag: Tag.EngineHP.rawValue)
        
        let engineTorque = "\(model.torque)"
        self.addDataList(title: "토크", value: engineTorque, forButtonTag: Tag.EngineTorque.rawValue)
        
        let engineWeight = "\(model.weight)"
        self.addDataList(title: "중량", value: engineWeight, forButtonTag: Tag.Weight.rawValue)
        
        self.specPositionY += 20
        
        let drive = String(Array(model.enginePosition.characters)[0]).stringByAppendingString((String(Array(model.transmission.characters)[0]))).uppercaseString
        self.addDataList(title: "구동방식", value: drive)
        
        var gearbox = ""
        if model.gearboxType == "automatic" {
            gearbox = gearbox.stringByAppendingString("자동")
        } else if model.gearboxType == "manual" {
            gearbox = gearbox.stringByAppendingString("수동")
        }
        if model.gearboxMaxLevel > 0 {
            gearbox = gearbox.stringByAppendingString("\(model.gearboxMaxLevel) 단")
        }
        self.addDataList(title: "변속기", value: gearbox)
        
        let born = "\(model.born)"
        self.addDataList(title: "출시년도", value: born)
        
        self.specPositionY += 20
        
        let efficiency = "\(String(format: "%.1f", (100 / model.efficiencyEconomy)))km/l"
        self.addDataList(title: "연비", value: efficiency, forButtonTag: Tag.EfficiencyEconomy.rawValue)
        
        if model.efficiencySport > 0 {
            self.addDataList(title: "스포츠모드", value: "(\(String(format: "%.1f", (100 / model.efficiencySport)))km/l)", forButtonTag: Tag.EfficiencySport.rawValue)
        }
        
    }
    
    func buttonDidTouch(button: UIButton) {
        print("buttonDidTouch: \(button.tag)")
        
        var spec = ""
        
        switch button.tag {
            case Tag.EngineHP.rawValue:
                spec = "hp"
            case Tag.EngineTorque.rawValue:
                spec = "torque"
            case Tag.Weight.rawValue:
                spec = "weight"
            case Tag.EfficiencyEconomy.rawValue:
                spec = "efficiencyEconomy"
            case Tag.EfficiencySport.rawValue:
                spec = "efficiencySport"
            default:
                return
                //
        }
        let sequenceViewController = CarSequenceViewController()
        sequenceViewController.spec = spec
        self.navigationController?.pushViewController(sequenceViewController, animated: true)
        
    }
    
    func addDataList(title title: String, value: String, indent: CGFloat = 0.0, forButtonTag: Int = 0) {
        
        self.specContainer.sizeToFit()
        let specViewSize = self.specContainer.bounds.size
        var frameTitle = CGRectZero
        
        frameTitle.origin.x = indent
        frameTitle.origin.y = self.specPositionY
        frameTitle.size.width = 100
        frameTitle.size.height = 20
        
        if forButtonTag != 0 {
            let buttonTitle = UIButton(frame: frameTitle)
//            buttonTitle.setTitleColor(UIColor.blackColor(), forState: .Normal)
            buttonTitle.backgroundColor = UIColor.blackColor()
            buttonTitle.contentHorizontalAlignment = .Left
            buttonTitle.tag = forButtonTag
            buttonTitle.addTarget(self, action: #selector(CarDetailViewController.buttonDidTouch(_:)), forControlEvents: .TouchUpInside)
            buttonTitle.setTitle(title, forState: .Normal)
            buttonTitle.userInteractionEnabled = true
            self.specContainer.addSubview(buttonTitle)
        } else {
            let labelTitle = UILabel(frame: frameTitle)
            labelTitle.text = title
            self.specContainer.addSubview(labelTitle)
        }
        
        var frameValue = CGRectZero
        frameValue.origin.x = frameTitle.size.width
        frameValue.origin.y = self.specPositionY
        frameValue.size.width = specViewSize.width - frameValue.origin.x
        frameValue.size.height = 20
        
        let labelValue = UILabel(frame: frameValue)
        labelValue.text = value
        self.specContainer.addSubview(labelValue)
        
        self.specPositionY += 20 + 4
        
    }
    
}
