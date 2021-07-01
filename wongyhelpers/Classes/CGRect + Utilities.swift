//
//  CGRect + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

import UIKit

public extension CGRect {
    var withZeroOrigin: CGRect {
        return CGRect(origin: CGPoint.zero, size: self.size)
    }
    
    var withZeroX: CGRect {
        return CGRect(origin: CGPoint(x: 0, y: self.origin.y), size: self.size)
    }
    
    var with1Heigh: CGRect {
        return CGRect(origin: self.origin, size: CGSize(width: self.size.width, height: 1))
    }
    
    var bottomLeftPoint: CGPoint {
        return CGPoint(x: self.origin.x, y: self.origin.y + self.size.height)
    }
    
    func withHeight(height: CGFloat) -> CGRect {
        return CGRect(origin: self.origin, size: CGSize(width: self.size.width, height: height))
    }
}
