//
//  Numbers+Rounding.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

/// Based on http://www.globalnerdy.com/2016/01/26/better-to-be-roughly-right-than-precisely-wrong-rounding-numbers-with-swift/

import Foundation

extension Double {
    /// Rounds the number to the nearest decimal point, going right.
    /// Example 123.76: rounded to 1 is 123.8, rounded to 0 is 124, rounded to -1 is 120
    ///
    /// - Parameter points: What decimal point to round to
    /// - Returns: A new rounded double
    func rounded(toDecimal points: Int) -> Double {
        return roundThis(value: self, toDecimal: points)
    }
}

extension Float {
    /// Rounds the number to the nearest decimal point, going right.
    /// Example 123.76: rounded to 1 is 123.8, rounded to 0 is 124, rounded to -1 is 120
    ///
    /// - Parameter points: What decimal point to round to
    /// - Returns: A new rounded float
    func rounded(toDecimal points: Int) -> Float {
        return Float(roundThis(value: Double(self), toDecimal: points))
    }
}

// MARK: - Private

// Must be outside the extension because otherwise the compiler gets confused with the round function, which is otherwise mutating.
fileprivate func roundThis(value: Double, toDecimal point: Int) -> Double {
    let decimal = nearest(decimalPoint: point)
    return round(value / decimal) * decimal
}

fileprivate func nearest(decimalPoint point: Int) -> Double {
    return 1.0 / pow(10.0,Double(point))
}
