//
//  XHKIT+NSTimer.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/22.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_NSTimer: Timer {
    
}

extension Timer {
    
    /// block回调
    @objc class func execBlock(timer: Timer) {
        if timer.userInfo != nil {
            let block: (_ timer: Timer)->() = timer.userInfo as! (_ timer: Timer)->()
            block(timer)
        }
    }
    
    /// 初始化定时器,直接加载到runloop中去
    class func scheduledTimerWithTimeInterval(seconds: TimeInterval, block: ((_ timer: Timer)->()), repeats: Bool) -> Timer {
        return Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(execBlock(timer:)), userInfo: block, repeats: repeats)
    }
    
    /// 初始化定时器,需要手动加载到runloop中去
    class func timerWithTimeInterval(seconds: TimeInterval, block: ((_ timer: Timer)->()), repeats: Bool) -> Timer {
        return Timer.init(timeInterval: seconds, target: self, selector: #selector(execBlock(timer:)), userInfo: block, repeats: repeats)
    }
    
}
