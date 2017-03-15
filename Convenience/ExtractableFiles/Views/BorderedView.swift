//
//  BorderedView.swift
//  Source: https://gist.github.com/mrkd/4353238540f684eb40cec10b8dd396ed
//

import UIKit

@IBDesignable
public class BorderedView: UIView {

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

}
