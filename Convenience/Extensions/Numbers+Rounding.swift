//
//  Numbers+Rounding.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

/// Based on http://www.globalnerdy.com/2016/01/26/better-to-be-roughly-right-than-precisely-wrong-rounding-numbers-with-swift/

import Foundation

// Must be outside the extension because otherwise the compiler gets confused with the round function, which is otherwise mutating.
fileprivate func roundThis(value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}

extension Double {
    func rounded(toDecimalPoints points: Int) -> Double {
        let decimal: Double = 1.0 / pow(10.0,Double(points))
        return roundThis(value: self, toNearest: decimal)
    }
}
