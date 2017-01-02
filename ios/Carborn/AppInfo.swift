//
//  AppInfo.swift
//  Carborn
//
//  Created by pureye4u on 01/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import Foundation

struct Version {
    init() {
        major = 0
        minor = 0
        build = 0
    }
    init(string: String!) {
        if string == nil {
            return
        }
        var versionArray: [Int] = [0, 0, 0]
        let versionStringArray = string.components(separatedBy: ".")
        let count = versionStringArray.count
        for i in 0..<3 {
            if i < count,
                let version = Int(versionStringArray[i]) {
                versionArray[i] = version
            }
        }
        major = versionArray[0]
        minor = versionArray[1]
        build = versionArray[2]
    }
    init(releaseString: String!, buildString: String!) {
        var versionArray: [Int] = [0, 0, 0]
        if releaseString != nil {
            let versionStringArray = releaseString.components(separatedBy: ".")
            let count = versionStringArray.count
            for i in 0..<2 {
                if i < count,
                    let version = Int(versionStringArray[i]) {
                    versionArray[i] = version
                }
            }
        }
        if buildString != nil {
            if let version = Int(buildString) {
                versionArray[2] = version
            }
        }
        major = versionArray[0]
        minor = versionArray[1]
        build = versionArray[2]
    }
    var major = 0
    var minor = 0
    var build = 0
    var string: String {
        get {
            return "\(major).\(minor).\(build)"
        }
    }
    var number: Int {
        get {
            return major * 100000000 + minor * 10000 + build
        }
    }
    static func <(lhs: Version, rhs: Version) -> Bool {
        return lhs.number < rhs.number
    }
    static func <=(lhs: Version, rhs: Version) -> Bool {
        return lhs.number <= rhs.number
    }
    static func >(lhs: Version, rhs: Version) -> Bool {
        return lhs.number > rhs.number
    }
    static func >=(lhs: Version, rhs: Version) -> Bool {
        return lhs.number >= rhs.number
    }
    static func ==(lhs: Version, rhs: Version) -> Bool {
        return lhs.number == rhs.number
    }
    static var maxValue: Version {
        get {
            var version = Version()
            version.major = 9999
            version.minor = 9999
            version.build = 9999
            
            return version
        }
    }
    static var minValue: Version {
        get {
            return Version()
        }
    }
}

class AppInfo {
    
    var version: Version {
        get {
            guard let info = Bundle.main.infoDictionary else {
                return Version()
            }
            let release = info["CFBundleShortVersionString"] as? String
            let build = info["CFBundleVersion"] as? String
            return Version(releaseString: release, buildString: build)
        }
    }
    
    //MARK: Shared Instance
    static let sharedInstance: AppInfo = AppInfo()
    
}
