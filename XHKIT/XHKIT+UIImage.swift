//
//  XHKIT+UIImage.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/21.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UIImage: UIImage {

}

extension UIImage {
    
    /// 根据颜色生成图片
    class func imageWithColor(color: UIColor) -> UIImage {
       return UIImage.imageWithColor(color: color, size: CGSize(width: 1, height: 1))
    }
    
    /// 根据颜色生成图片 自定义生成图片的大小
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        if size.height < 0 || size.width < 0 {
            return UIImage()
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 设置图片的圆角
    func imageByRoundCornerRadius(radius: CGFloat) -> UIImage {
        return self.imageByRoundCornerRadius(radius: radius, borderWidth: 0, borderColor: nil)
    }
    
    /// 设置图片圆角, 边界线, 边界线颜色
    func imageByRoundCornerRadius(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) -> UIImage {
        return self.imageByRoundCornerRadius(radius: radius, corners: .allCorners, borderWidth: borderWidth, borderColor: borderColor, borderLineJoin: CGLineJoin.miter)
    }
    
    /// 设置图片圆角, radius: 圆角值; corners: (topLeft, topRight, bottomLeft, bottomRight); borderWidth: 边线宽度; borderColor: 边线颜色; borderLineJoin: 衔接方式<https://blog.csdn.net/keep_silence_/article/details/7941125>
    func imageByRoundCornerRadius(radius: CGFloat, corners: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor?, borderLineJoin: CGLineJoin) -> UIImage {
        var newCorners = UIRectCorner()
        if corners != UIRectCorner.allCorners {
            if corners.contains(UIRectCorner.topLeft) {
                newCorners.insert(UIRectCorner.bottomLeft)
            }
            if corners.contains(UIRectCorner.topRight) {
                newCorners.insert(UIRectCorner.bottomRight)
            }
            if corners.contains(UIRectCorner.bottomLeft) {
                newCorners.insert(UIRectCorner.topLeft)
            }
            if corners.contains(UIRectCorner.bottomRight) {
                newCorners.insert(UIRectCorner.topRight)
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: newCorners, cornerRadii: CGSize(width: radius, height: borderWidth))
            path.close()
            
            context?.saveGState()
            path.addClip()
            
            context?.draw(self.cgImage!, in: rect)
            context?.restoreGState()
        }
        if borderWidth > 0 && borderWidth < minSize / 2  {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: newCorners, cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
            path.close()
            
            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            borderColor?.setStroke()
            path.stroke()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
