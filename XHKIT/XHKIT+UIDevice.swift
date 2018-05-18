//
//  XHKIT+UIDevice.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/17.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UIDevice: UIDevice {
    
}

extension UIDevice {
    
    /// 获取系统版本号
    class func systemVersion() -> Double {
        return Double(self.current.systemVersion)!
    }
    
    /// 判断设备是不是iPad
    class func isiPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }
    
    /// 判断设备是不是模拟器
    class func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
    
    /// 判断设备是否越狱
    class func isJailBroken() -> Bool {
        if self.isSimulator() == true {
            // 不判断模拟器
            return false
        }
        let paths = ["/Applications/Cydia.app",
                     "/private/var/lib/apt/",
                     "/private/var/lib/cydia",
                     "/private/var/stash"]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) == true {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        let path = "/private/" + NSString.UUID()
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
    
    /// 判断设备是否能够拨打电话
    class func canMakePhoneCall() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    
    /// 判断设备型号
    class func machineModel() -> String {
        var model = utsname()
        uname(&model)
        let machineMirror = Mirror(reflecting: model.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
                
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 判断设备型号名称
    class func machineModelName() -> String {
        let model = self.machineModel()
        if model.count == 0 {
            return "未知"
        }
        let dic = [
            //iWatch
            "Watch1,1": "Apple Watch 38mm",
            "Watch1,2": "Apple Watch 42mm",
            "Watch2,3": "Apple Watch Series 2 38mm",
            "Watch2,4": "Apple Watch Series 2 42mm",
            "Watch2,6": "Apple Watch Series 1 38mm",
            "Watch1,7": "Apple Watch Series 1 42mm",
            
            //iPod
            "iPod1,1": "iPod touch 1",
            "iPod2,1": "iPod touch 2",
            "iPod3,1": "iPod touch 3",
            "iPod4,1": "iPod touch 4",
            "iPod5,1": "iPod touch 5",
            "iPod7,1": "iPod touch 6",
            
            //iPhone
            "iPhone1,1": "iPhone 1G",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4 (GSM)",
            "iPhone3,2": "iPhone 4",
            "iPhone3,3": "iPhone 4 (CDMA)",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5",
            "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c",
            "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone7,2": "iPhone 6",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE",
            "iPhone9,1": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,3": "iPhone 7",
            "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1" : "iPhone 8 (CDMA)",
            "iPhone10,4" : "iPhone 8 (GSM)",
            "iPhone10,2" : "iPhone 8 Plus (CDMA)",
            "iPhone10,5" : "iPhone 8 Plus (GSM)",
            "iPhone10,3" : "iPhone X (CDMA)",
            "iPhone10,6" : "iPhone X (GSM)",
            
            // iPad
            "iPad1,1": "iPad 1",
            "iPad2,1": "iPad 2 (WiFi)",
            "iPad2,2": "iPad 2 (GSM)",
            "iPad2,3": "iPad 2 (CDMA)",
            "iPad2,4": "iPad 2",
            "iPad2,5": "iPad mini 1",
            "iPad2,6": "iPad mini 1",
            "iPad2,7": "iPad mini 1",
            "iPad3,1": "iPad 3 (WiFi)",
            "iPad3,2": "iPad 3 (4G)",
            "iPad3,3": "iPad 3 (4G)",
            "iPad3,4": "iPad 4",
            "iPad3,5": "iPad 4",
            "iPad3,6": "iPad 4",
            "iPad4,1": "iPad Air",
            "iPad4,2": "iPad Air",
            "iPad4,3": "iPad Air",
            "iPad4,4": "iPad mini 2",
            "iPad4,5": "iPad mini 2",
            "iPad4,6": "iPad mini 2",
            "iPad4,7": "iPad mini 3",
            "iPad4,8": "iPad mini 3",
            "iPad4,9": "iPad mini 3",
            "iPad5,1": "iPad mini 4",
            "iPad5,2": "iPad mini 4",
            "iPad5,3": "iPad Air 2",
            "iPad5,4": "iPad Air 2",
            "iPad6,3": "iPad Pro (9.7 inch)",
            "iPad6,4": "iPad Pro (9.7 inch)",
            "iPad6,7": "iPad Pro (12.9 inch)",
            "iPad6,8": "iPad Pro (12.9 inch)",
            
            // AppleTV
            "AppleTV2,1": "Apple TV 2",
            "AppleTV3,1": "Apple TV 3",
            "AppleTV3,2": "Apple TV 3",
            "AppleTV5,3": "Apple TV 4",
            
            // Simulator
            "i386": "Simulator x86",
            "x86_64": "Simulator x64",
            
        ]
        return dic[model] ?? "未知"
    }
    
    /// 系统开机启动时间
    class func systemUptime() -> Date {
        let time = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: (0 - time))
    }
    
    /// 获取当前wifi的IP地址
    class func getLocalIPAddressForCurrentWiFi() -> String? {
        var address: String?
        
        // get list of all interfaces on the local machine
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        guard let firstAddr = ifaddr else {
            return nil
        }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            
            let interface = ifptr.pointee
            
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
    // 根据网址请求 获取IP地址, 如传 www.baidu.com
    class func getIPAddressFromDNSQuery(url: String) -> String? {
        let host = CFHostCreateWithName(nil, url as CFString).takeRetainedValue()
        CFHostStartInfoResolution(host, .addresses, nil)
        var success: DarwinBoolean =  false
        if let address = CFHostGetAddressing(host, &success)?.takeUnretainedValue() as NSArray?, let theAddress = address.firstObject as? NSData {
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            if getnameinfo(theAddress.bytes.assumingMemoryBound(to: sockaddr.self), socklen_t(theAddress.length), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                let numAddress = String(cString: hostname)
                return numAddress
            }
            return nil
        }
        return nil
    }

    /// 获取磁盘空间
    class func diskSpace() -> Int64 {
        do {
           let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            var space = attrs[FileAttributeKey.systemSize] as! Int64
            if space < 0 {
                space = -1
            }
            return space
        } catch let error {
            print(error.localizedDescription)
            return -1
        }
    }
    
    /// 获取磁盘剩余的空间
    class func diskSpaceFree() -> Int64 {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            var space = attrs[FileAttributeKey.systemFreeSize] as! Int64
            if space < 0 {
                space = -1
            }
            return space
        } catch let error {
            print(error.localizedDescription)
            return -1
        }
    }
    
    /// 获取磁盘已经使用的空间
    class func diskSpaceUesd() -> Int64 {
        if self.diskSpace() < 0 || self.diskSpaceFree() < 0 {
            return -1
        }
        let used = self.diskSpace() - self.diskSpaceFree()
        if used < 0 {
            return -1
        }
        return used
    }
    
}
