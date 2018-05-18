//
//  XHKIT+NSString.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/15.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

extension String {
   
    //MARK: - md5加密 -
    /// md5加密
    func md5String() -> String! {
        let str = self.cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str, strLen, result)
        let md5String = NSMutableString()
        for i in 0..<digestLen {
            md5String.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: md5String as String)
    }
    
    //MARK: - sha1加密 -
    /// sha1加密
    func sha1String() -> String! {
        let str = self.cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str, strLen, result)
        let sha1String = NSMutableString()
        for i in 0..<digestLen {
            sha1String.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: sha1String as String)
    }
    
    //MARK: - sha256加密 -
    /// sha256加密
    func sha256String() -> String! {
        let str = self.cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(str, strLen, result)
        let sha256String = NSMutableString()
        for i in 0..<digestLen {
            sha256String.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: sha256String as String)
    }
  
    //MARK: - utf8转码 -
    /// utf8转码
    func utf8String() -> String! {
        if self.count > 0 {
            return NSString(data: (self.data(using: .utf8))!, encoding: String.Encoding.utf8.rawValue)! as String
        }
        return ""
    }
    
    //MARK: - base64 解码 -
    /// base64 解码
    func fromBase64() -> String! {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return ""
        }
        return String(data: data, encoding: .utf8)
        
    }
    
    //MARK: - base 64 编码 -
    /// base 64 编码
    func toBase64() -> String! {
        guard let data = self.data(using: .utf8) else {
            return ""
        }
        return data.base64EncodedString()
    }
    
    //MARK: - 将原始URL编码为合法的URL -
    /// 将原始URL编码为合法的URL
    func URLEncoded() -> String! {
        guard let encodeURLStr = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return ""
        }
        return encodeURLStr
    }
    
    //MARK: - 将编码后的URL解码为原始的URL -
    /// 将编码后的URL解码为原始的URL
    func URLDecoded() -> String! {
        return self.removingPercentEncoding ?? ""
    }
    
    //MARK: - 计算字符串大小 font默认:12 lineBreakMode默认: byWordWrapping -
    /// 计算字符串大小 font默认:12 lineBreakMode默认: byWordWrapping
    func sizeForFont(font: UIFont? = UIFont.systemFont(ofSize: 12), size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        if self.count > 0 {
            let attr = NSMutableDictionary()
            attr[NSAttributedStringKey.font] = font
            if lineBreakMode != .byWordWrapping {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineBreakMode = lineBreakMode
                attr[NSAttributedStringKey.paragraphStyle] = paragraphStyle
            }
            let rect = NSString(string: self).boundingRect(with: size, options:[.usesLineFragmentOrigin, .usesFontLeading], attributes: attr as? [NSAttributedStringKey : Any], context: nil)
            return rect.size
            
        }
        return CGSize.zero
    }
    
    //MARK: - 根据font计算文字的宽度 -
    /// 根据font计算文字的宽度
    func widthForFont(font: UIFont) -> CGFloat {
        return self.sizeForFont(font: font, size: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), lineBreakMode: .byWordWrapping).width
    }
    
    //MARK: - 根据font计算文字的高度 -
    /// 根据font计算文字的高度
    func heightForFont(font: UIFont, width: CGFloat) -> CGFloat {
        return self.sizeForFont(font: font, size: CGSize(width: width, height: CGFloat(MAXFLOAT)), lineBreakMode: .byWordWrapping).height
    }
    
    //MARK: - 是否匹配该正则表达式 -
    /// 是否匹配该正则表达式
    func matchesRegex(regex: String, options: NSRegularExpression.Options) -> Bool {
        let pattern = try? NSRegularExpression(pattern: regex, options: options)
        if pattern == nil {
            return false
        }
        if pattern?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count)) ?? 0 > 0 {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - 将制定字符串通过正则表达进行替换,并返回新的字符串 -
    /// 将制定字符串通过正则表达进行替换,并返回新的字符串
    func stringByReplacingRegx(regex: String, options: NSRegularExpression.Options, replacement: String) -> String {
        let pattern = try? NSRegularExpression(pattern: regex, options: options)
        if pattern == nil {
            return self
        }
        return pattern?.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: replacement) ?? self
    }
    
    //MARK: - 验证身份证号码是否合法 -
    /// 验证身份证号码是否合法
    func isLegalForIDCardNumber() -> Bool {
        if self.last == "x" {
            return false
        }
        let regex = "(^[0-9]{15}$)|([0-9]{17}([0-9]|[X])$)"
        return self.matchesRegex(regex: regex, options: NSRegularExpression.Options(rawValue: 0))
        
    }
    
    //MARK: - 验证银行卡号码是否合法 -
    /// 验证银行卡号码是否合法
    func isLegalForBankCardNumber() -> Bool {
        for char in self {
            if char == "_" {
                return false
            }
        }
        let regex = "[0-9]{15,18}"
        return self.matchesRegex(regex: regex, options: NSRegularExpression.Options(rawValue: 0))
    }
    
    //MARK: - 验证手机号码是否合法 -
    /// 验证手机号码是否合法
    func isLegalForPhoneNumber() -> Bool {
        for char in self {
            if char == "_" {
                return false
            }
        }
        let regex = "1[0-9]{10}"
        return self.matchesRegex(regex: regex, options: NSRegularExpression.Options(rawValue: 0))
    }
    
    /// 获取UUID(UUID也并不是唯一的, 设备越狱依然可以修改!)
    func UUID() -> String {
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
        return uuidString
    }
    
    /// 去除字符串"首尾"的空格, 换行
    func stringByTrim() -> String {
        let set = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: set)
    }
    
    /// 判断字符是不是空白 如果有空格或者换号也不算是空白
    func isNotBlank() -> Bool {
        if self.count == 0 {
            return true
        }
        let blank: NSCharacterSet = NSCharacterSet.whitespacesAndNewlines as NSCharacterSet
        for i in 0..<self.count {
            let c: UniChar = CFStringGetCharacterAtIndex(self as CFString, i)
            if blank.characterIsMember(c) == false {
                return true
            }
        }
        return false
    }
    
    /// 获取一个字符串全部的Range
    func rangeOfAll() -> NSRange {
        if self.count == 0 {
            return NSRange(location: 0, length: 0)
        }
        return NSRange(location: 0, length: self.count)
    }
    
}

extension NSString {
    /// 获取UUID(UUID也并不是唯一的, 设备越狱依然可以修改!)
    class func UUID() -> String {
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
        return uuidString
    }
}
