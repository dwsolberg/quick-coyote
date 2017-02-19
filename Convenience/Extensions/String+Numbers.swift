//
//  String+Numbers.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

extension String {

    var intValue: Int? {
        let trimmed = self.numbersAndDecimalOnly
        return Int(trimmed)
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

    var numbersAndDecimalOnly: String {
        let numberCharacterSet = CharacterSet(charactersIn: "1234567890.")
        let removeSet = numberCharacterSet.inverted
        let numberArray = self.components(separatedBy: removeSet)
        return numberArray.reduce("") { (base, numbers) -> String in
            return base + numbers
        }
    }
}
