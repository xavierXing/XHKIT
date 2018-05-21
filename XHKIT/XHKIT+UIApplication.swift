//
//  XHKIT+UIApplication.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/21.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UIApplication: UIApplication {

}

extension UIApplication {
    
    /// documents URL
    var documentsURL: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        }
    }
    
    /// documents 路径
    var documentsPath: String {
        get {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }
    }
    
    /// caches URL
    var cachesURL: URL {
        get {
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
        }
    }
    
    /// caches 路径
    var cachesPath: String {
        get {
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        }
    }
    
    /// library URL
    var libraryURL: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
        }
    }
    
    /// library 路径
    var libraryPath: String {
        get {
            return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        }
    }
    
    /// appBundleName
    var appBundleName: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        }
    }
    
    /// appBundleID
    var appBundleID: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
        }
    }
    
    /// appVersion
    var appVersion: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }
    }
    
    /// appBuildVersion
    var appBuildVersion: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        }
    }
    
    /// 验证app是不是正版应用
    var isPirated: Bool {
        get {
            if UIDevice.isSimulator() == true {
                // 模拟器肯定不是在appStore上下载的app
                return true
            }
            if getgid() <= 10 {
                return true
            }
            if (Bundle.main.infoDictionary!["SignerIdentity"] != nil) {
                return true
            }
            if self.fileExistInMainBundle(name: "_CodeSignature") == true {
                return true
            }
            if self.fileExistInMainBundle(name: "SC_Info") == true {
                return true
            }
            return false
        }
    }
    
}

extension UIApplication {
    
    // 验证文件的存储路径
    func fileExistInMainBundle(name: String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = bundlePath + name
        return FileManager.default.fileExists(atPath: path)
    }
    
    // 打开状态栏的loading标识
    func incrementNetWorkActivityCount() {
        self.isNetworkActivityIndicatorVisible = true
    }
    
    // 关闭状态栏的loading标识
    func decrementNetWorkActivityCount() {
        self.isNetworkActivityIndicatorVisible = false
    }
    
}

