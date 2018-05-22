//
//  ViewController.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/15.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let clearStr = "这是一个即将要被加密的字符串"
//        print("md5 : \(clearStr.md5String()) sha1: \(clearStr.sha1String()) sha256: \(clearStr.sha256String())")
        
//        let base64 = clearStr.toBase64()
//        print("base64编码: \(base64)")
        
//        print("base64解码: \(base64?.fromBase64())")
        
//        let size = clearStr.sizeForFont(font: UIFont.systemFont(ofSize: 12), size: CGSize(width: 100, height: 20), lineBreakMode: .byWordWrapping)
//        print(size.width, size.height)
        
//        let width = clearStr.widthForFont(font: UIFont.systemFont(ofSize: 12))
//        print(width)
        
//        let height = clearStr.heightForFont(font: UIFont.systemFont(ofSize: 12), width: 300)
//        print(height)
        
//        let phoneNum = "13582960"
//        print(phoneNum.isLegalForPhoneNumber())
//
//        let idCard = "13920600019"
//        print(idCard.isLegalForIDCardNumber())
//
//        let bankNum = "6224214941"
//        print(bankNum.isLegalForBankCardNumber())
        
//        let spaceAndNewline = "   \n\n\n  112233\n22 "
//        print(spaceAndNewline.stringByTrim(), spaceAndNewline)
        
//        let blank = "  \n \n  "
//        print(blank.isNotBlank())

//        print(UIDevice.systemVersion())
        
//        print(UIDevice.isiPad())
//
//        print(UIDevice.isSimulator())
        
//        print(UIDevice.isJailBroken())
        
//        print(UIDevice.canMakePhoneCall())
        
//        print(UIDevice.machineModelName())
        
//        print(UIDevice.systemUptime())
        
//        print(UIDevice.getLocalIPAddressForCurrentWiFi())
        
//        print(UIDevice.getIPAddressFromDNSQuery(url: "m.news18a.com"))
        
//        print(UIDevice.diskSpace() / Int64(1000) / Int64(1000) / Int64(1000))
//        
//        print(UIDevice.diskSpaceFree() / Int64(1000) / Int64(1000) / Int64(1000))
        
//        print(UIDevice.diskSpaceUesd() / Int64(1000) / Int64(1000) / Int64(1000))
        
//        let image = UIImage(named: "head")?.imageByRoundCornerRadius(radius: 30)
//        let image = UIImage(named: "head")?.imageByRoundCornerRadius(radius: 0, borderWidth: 10, borderColor: UIColor.red)
        
        
//        let image = UIImage(named: "head")?.imageByRoundCornerRadius(radius: 30, corners: [.topRight, .topLeft], borderWidth: 0, borderColor: nil, borderLineJoin: CGLineJoin.miter)
//
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
//
//        imageView.setLayerShadow(color: UIColor.black, offset: CGSize(width: 10, height: 0), radius: 5)
//
//        self.view.addSubview(imageView)
        
//        print(self.view.getViewInController())
        
//        let image = UIImage(named: "head")
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
//        imageView.createBlurView(style: .light)
//        self.view.addSubview(imageView)
        
//        let timer = Timer.timerWithTimeInterval(seconds: 2, block: { (timer) in
//            print("初始化  timer  \(timer)")
//
//        }, repeats: true)
//        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
//
//        let againTimer = Timer.scheduledTimerWithTimeInterval(seconds: 2, block: { (timer) in
//            print("初始化  againTimer  \(timer)")
//        }, repeats: false)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.incrementNetWorkActivityCount()
    }

}

