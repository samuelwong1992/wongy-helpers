//
//  UITextField + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

import UIKit

extension UITextField {
    func textLengthAfterChange(changedRange range: NSRange, replacementString string: String) -> Int {
        let text = self.text != nil ? self.text! : ""
        return text.count + string.count - range.length
    }
    
    func textAfterChange(changedRange range: NSRange, replacementString string: String) -> String {
        let text = self.text != nil ? self.text! : ""
        let nsText = text as NSString
        return nsText.replacingCharacters(in: range, with: string)
    }
    
    var textLength: Int {
        if let text = self.text {
            return text.count
        }
        
        return 0
    }
    
    func validateText() -> Bool {
        if self.text == nil { return false }
        if self.text == "" { return false }
        
        return true
    }
}
