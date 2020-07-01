//
//  NSDictionary.swift
//  ProtonTest
//
//  Created by Sergey Chehuta on 19/03/2020.
//  Copyright © 2020 Proton Technologies AG. All rights reserved.
//

import Foundation

extension NSDictionary {
    
    public func string(_ keyPath: Key) -> String? {
        return value(forKeyPath: keyPath as! String) as? String
    }
    
    public func stringValue(_ keyPath: Key, default: String = "") -> String {
        return string(keyPath) ?? `default`
    }
    
    public func int(_ key: Key) -> Int? {
        return self[key] as? Int
    }
    
    public func intValue(_ key: Key, default: Int = 0) -> Int {
        return int(key) ?? `default`
    }

    public func double(_ key: Key) -> Double? {
        return self[key] as? Double
    }
    
    public func doubleValue(_ key: Key, default: Double = 0) -> Double {
        return double(key) ?? `default`
    }

}
