//
//  UIImage+Tint.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit
import CoreGraphics

/// Convenience methods for dealing with tintable images.
extension UIImage {
    
    var tintableImage: UIImage {
        if self.renderingMode == .alwaysTemplate {
            return self
        } else {
            return self.withRenderingMode(.alwaysTemplate)
        }
    }
    
    func imageFilledWithGradient(_ gradient: CGGradient) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: self.size.width * scale, height: self.size.height * scale))
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height * scale)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width * scale, height: self.size.height * scale)
        context?.draw(self.cgImage!, in: rect)
        
        context?.clip(to: rect, mask: self.cgImage!)
        context?.drawLinearGradient(gradient, start: CGPoint(x: 0,y: 0), end: CGPoint(x: 0,y: self.size.height * scale), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
