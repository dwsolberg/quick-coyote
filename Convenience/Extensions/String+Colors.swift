//
//  String+Colors.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

extension String {

    /// Transforms a hex color in the format "0xFFFFF", "0XFFFFFFFF", "#FFFFF", "#FFFFFFFF", "FFFFFF", and "FFFFFFFF" into the corresponding UIColor object. Returns nil if it doesn't recognize the format.
    func asColor() -> UIColor? {
        var convertedString = self
        if (self as NSString).range(of: "0x", options: NSString.CompareOptions.caseInsensitive).location == 0 {
            convertedString = self.substring(from: self.characters.index(self.startIndex, offsetBy: 2))
        }
        if (convertedString as NSString).range(of: "#", options: NSString.CompareOptions.caseInsensitive).location == 0 {
            convertedString = convertedString.substring(from: self.characters.index(self.startIndex, offsetBy: 1))
        }

        // If we can't make it into a int from a hex, then bail.
        let scanner = Scanner(string: convertedString)
        var hex: UInt64 = 0
        guard scanner.scanHexInt64(&hex) else {
            print("Could not create color from \(self) converted to hex \(hex)")
            return nil
        }

        let r, g, b, a: CGFloat

        // Case with 6 characters
        if convertedString.characters.count == 6 {
            r = CGFloat((hex & 0xff0000) >> 16) / 255
            g = CGFloat((hex & 0x00ff00) >> 8) / 255
            b = CGFloat((hex & 0x0000ff) >> 0) / 255
            a = 1
        }
        // Case with 8 characters -> alpha
        else if convertedString.characters.count == 8 {
            r = CGFloat((hex & 0xff000000) >> 24) / 255
            g = CGFloat((hex & 0x00ff0000) >> 16) / 255
            b = CGFloat((hex & 0x0000ff00) >> 8) / 255
            a = CGFloat((hex & 0x000000ff) >> 0) / 255
        }
        // Anything else we don't handle
        else {
            print("Could not create color from \(self) converted to \(convertedString)")
            return nil
        }

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
