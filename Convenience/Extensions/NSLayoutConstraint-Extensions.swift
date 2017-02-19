//
//  NSLayoutConstraint-Extensions.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

/// Convenience methods to create layout constraints.
extension UIView {
    
    func constraintPresentWidth() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.frame.width)
    }
    
    func constraintPresentHeight() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.frame.height)
    }
    
    func constraintPresentXOrigin(inside container: UIView) -> NSLayoutConstraint {
            return NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: self.frame.origin.x)
    }
    
    func constraintPresentYOrigin(inside container: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: self.frame.origin.y)
    }
    
    func constraintCenterX(inside container: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1.0, constant: constant)
    }
    
    func constraintCenterY(inside container: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1.0, constant: constant)
    }
    
    func constraintBelowView(_ view: UIView, constant:CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: constant)
    }
    
    func constraintRightOfView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: constant)
    }
    
    
    func constraintAlignTop(inside container : UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: container, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: constant)
    }
    
    func constraintAlignBottom(inside container : UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: constant)
    }
    
    func constraintAlignLeft(inside container : UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: .equal, toItem: container, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: constant)
    }
    
    func constraintAlignRight(inside container : UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: .equal, toItem: container, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -constant)
    }
    
    func constraintsToBox(inside container : UIView, withMarginsAllSides margins: CGFloat = 0) -> [NSLayoutConstraint] {
        let top = constraintAlignTop(inside: container, constant: margins)
        let bottom = constraintAlignBottom(inside: container, constant: margins)
        let left = constraintAlignLeft(inside: container, constant: margins)
        let right = constraintAlignRight(inside: container, constant: margins)
        return [top, bottom, left, right]
    }
    
    func constraintsToLeftPin(inside container: UIView, withMargin margin: CGFloat = 0, withWidth width: CGFloat) -> [NSLayoutConstraint]
    {
        let top = constraintAlignTop(inside: container, constant: 0)
        let bottom = constraintAlignBottom(inside: container, constant: 0)
        let left = constraintAlignLeft(inside: container, constant: margin)
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        return [top, bottom, left, width]
    }
    
    func constraintsToPinBesideView(_ leftView: UIView, inside container: UIView, withMargin margin: CGFloat = 0, withWidth width : CGFloat) -> [NSLayoutConstraint]
    {
        let top = constraintAlignTop(inside: container, constant: 0)
        let bottom = constraintAlignBottom(inside: container, constant: 0)
        let left = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: .equal, toItem: leftView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: margin)
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        return [top, bottom, left, width]
    }
}
