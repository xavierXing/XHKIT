//
//  XHKIT+UITextField.swift
//  XHKIT
//
//  Created by LeoTai on 2018/5/22.
//  Copyright © 2018年 Xavier. All rights reserved.
//

import UIKit

class XHKIT_UITextField: UITextField {
    
}

extension UITextField {
    
    /// 输入框 全选
    func selectAllText() {
        let range = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
        self.selectedTextRange = range
    }
    
    /// 选取文字范围
    func selectRange(range: NSRange) {
        let begin = self.beginningOfDocument
        let start = self.position(from: begin, offset: range.location)
        let end = self.position(from: begin, offset: NSMaxRange(range))
        let selectionRange = self.textRange(from: start!, to: end!)
        self.selectedTextRange = selectionRange
    }
}
