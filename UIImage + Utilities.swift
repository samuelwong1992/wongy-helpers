//
//  UIImage + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

import UIKit

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
    func invertedImage() -> UIImage? {
        let image = CIImage(cgImage: self.cgImage!)
        
        if let filter = CIFilter(name: "CIColorInvert") {
            filter.setDefaults()
            filter.setValue(image, forKey: kCIInputImageKey)

            let context = CIContext(options: nil)
            let imageRef = context.createCGImage(filter.outputImage!, from: image.extent)
            return UIImage(cgImage: imageRef!)
        }
        
        return nil
    }
    
    func invertedImageAsCGImage() -> CGImage? {
        let image = CIImage(cgImage: self.cgImage!)
        if let filter = CIFilter(name: "CIColorInvert") {
            filter.setDefaults()
            filter.setValue(image, forKey: kCIInputImageKey)

            let context = CIContext(options: nil)
            return context.createCGImage(filter.outputImage!, from: image.extent)
        }
        
        return nil
    }
    
    func monochromeImage() -> UIImage? {
        let image = CIImage(cgImage: self.cgImage!)
        
        if let filter = CIFilter(name: "CIColorMonochrome") {
            filter.setDefaults()
            filter.setValue(image, forKey: kCIInputImageKey)

            let context = CIContext(options: nil)
            let imageRef = context.createCGImage(filter.outputImage!, from: image.extent)
            return UIImage(cgImage: imageRef!)
        }
        
        return nil
    }
}
