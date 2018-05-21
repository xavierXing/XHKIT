//
//  XHKIT+UIView.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/21.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UIView: UIView {


}

extension UIView {
    
    
    var left: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.origin.x = left ?? 0
            self.frame = newFrame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var right: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.origin.x = right ?? 0 - frame.size.width
            self.frame = newFrame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var top: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.origin.y = top ?? 0
            self.frame = newFrame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.origin.x = bottom ?? 0 - newFrame.size.height
            self.frame = newFrame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var width: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.size.width = width ?? 0
            self.frame = newFrame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat? {
        set {
            var newFrame = self.frame
            newFrame.size.height = height ?? 0
            self.frame = newFrame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var centerX: CGFloat? {
        set {
            self.center = CGPoint(x: centerX ?? 0, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat? {
        set {
            self.center = CGPoint(x: self.center.x, y: centerY ?? 0)
        }
        get {
            return self.center.y
        }
    }
    
    var origin: CGPoint? {
        set {
            var newFrame = self.frame
            newFrame.origin = origin ?? CGPoint.zero
            self.frame = newFrame
        }
        get {
            return self.frame.origin
        }
    }
    
    var size: CGSize? {
        set {
            var newFrame = self.frame
            newFrame.size = size ?? CGSize.zero
            self.frame = newFrame
        }
        get {
            return self.frame.size
        }
    }
    
    /// 截图
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    /// 设置layer的阴影
    func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// 当前视图在哪个控制器上
    func getViewInController() -> UIViewController? {
        var next: UIResponder?
        next = self.next!
        repeat {
            if next != nil {
                return next as? UIViewController
            } else {
                next = next?.next
            }
        } while next != nil
        
        return nil
    }
    
    /// 创建毛玻璃蒙层
    func createBlurView(style: UIBlurEffectStyle) {
        let blurImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        blurImg.contentMode = .scaleAspectFill
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        visualEffectView.frame = blurImg.frame
        visualEffectView.alpha = 0.7
        
        blurImg.addSubview(visualEffectView)
        self.insertSubview(blurImg, belowSubview: self)
    }
    
}
