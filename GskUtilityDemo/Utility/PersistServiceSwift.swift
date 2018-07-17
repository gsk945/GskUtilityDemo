//
//  PersistServiceSwift.swift
//  GskUtilityDemo
//
//  Created by gsk on 2018/7/17.
//  Copyright © 2018年 gsk. All rights reserved.
//

import UIKit

/// Swift版的PersistService
class PersistServiceSwift {
    static let subpath = "/doc"
    
    static func set(_ obj: Any, key: String, classKey: String) {
        if let currentSetting = get(fromKey: classKey) as? Dictionary<String, Any> {
            let newSetting = NSMutableDictionary(dictionary: currentSetting)
            newSetting.setObject(obj, forKey: NSString(string: key))
            set(newSetting, key: classKey)
        }else {
            let newSetting = NSMutableDictionary(object: obj, forKey: NSString(string: key))
            set(newSetting, key: classKey)
        }
    }
    
    static func get(key: String, from classkey: String) -> Any? {
        if let currentSetting = get(fromKey: classkey) as? Dictionary<String, Any> {
            return currentSetting[key]
        }
        return nil
    }
    
    private static func set(_ obj : Any?, key : String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + subpath
        var file = NSMutableDictionary(contentsOfFile: path)
        if file == nil {
            file = NSMutableDictionary()
        }
        if obj == nil {
            file?.removeObject(forKey: key)
        }else {
            file?.setObject(obj!, forKey: NSString(string: key))
        }
        guard (file?.write(toFile: path, atomically: true))! else {
            print("persist fail!!")
            return
        }
    }
    
    private static func get(fromKey key : String) -> Any? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + subpath
        return NSDictionary(contentsOfFile: path)?.object(forKey: key)
    }
}
