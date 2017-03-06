//
//  String+Numbers.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

extension String {

    var intValueRounded: Int? {
        guard let doubled = self.doubleValue else { return nil }
        let rounded = round(doubled)
        return Int(rounded)
    }

    var doubleValue: Double? {
        let trimmed = self.numbersAndDecimalOnly
        return Double(trimmed)
    }

    var numbersOnly: String {
        let numberCharacterSet = CharacterSet(charactersIn: "1234567890")
        let removeSet = numberCharacterSet.inverted
        let numberArray = self.components(separatedBy: removeSet)
        return numberArray.reduce("") { (base, numbers) -> String in
            return base + numbers
        }
    }

    // TODO: Add locale because some places uses commas for decimals.
    var numbersAndDecimalOnly: String {
        let numberCharacterSet = CharacterSet(charactersIn: "1234567890.")
        let removeSet = numberCharacterSet.inverted
        let numberArray = self.components(separatedBy: removeSet)
        return numberArray.reduce("") { (base, numbers) -> String in
            return base + numbers
        }
    }
}
