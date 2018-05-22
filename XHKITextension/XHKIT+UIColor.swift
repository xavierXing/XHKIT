//
//  XHKIT+UIColor.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/22.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UIColor: UIColor {

}

extension UIColor {
    
    /// 随机色
    var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    /// 将16进制颜色转换为RGB
    convenience init(hexString: String) {
        //Scanner继承自NSObject，遵守NSCopying协议。是一个用于扫描指定字符串的抽象类
        let scanner = Scanner(string: hexString)
        var valueRGB: Int32 = 0
        if scanner.scanInt32(&valueRGB) == false {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        } else {
            self.init(
                red:CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green:CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue:CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha:CGFloat(1.0)
            )
        }
    }
    
}
