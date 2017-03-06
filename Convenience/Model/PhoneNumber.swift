//
//  PhoneNumber.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

/// This class hold a U.S.-formatted phone number 1-000-000-0000 and provides a method to call it.
// Requires a reference type (class) because it has to hold a webview for calling the number.
class PhoneNumber {
    
    let number: String
    fileprivate static var webView = UIWebView()

    init?(source unvalidated: String?) {
        guard let unvalidated = unvalidated else { return nil }
        guard let validNum = PhoneNumber.number(fromString: unvalidated) else { return nil }
        number = validNum
        guard let _ = components else { return nil }
    }

    /// Check whether the phone number is valid which means that it contains either 10 or 11 digits (11 includes the 1 before the number).
    static func number(fromString inputString: String) -> String? {

        let removeSet = CharacterSet(charactersIn: "1234567890").inverted
        let numberArray = inputString.components(separatedBy: removeSet)
        var plainNumbers = numberArray.reduce("") { (base, numbers) -> String in
            return base + numbers
        }
        if plainNumbers.characters.count == 10 {
            plainNumbers.insert("1", at: plainNumbers.startIndex)
        }
        guard plainNumbers.characters.count == 11 else { return nil }
        return plainNumbers
    }

    var formattedWithDashes: String {
        return components!.joined(separator: "-")
    }

    var formattedWithParens: String {
        var item = 0
        return components!.reduce("") { (composition, part) -> String in
            item += 1
            if item == 1 {
                return composition + part + " ("
            } else if item == 2 {
                return composition + part + ") "
            } else if item == 3 {
                return composition + part + "-"
            } else {
                return composition + part
            }
        }
    }
    
    func call() -> Bool {
        guard let phoneUrl = URL(string: "tel:" + number) else { return false }
        guard UIApplication.shared.canOpenURL(phoneUrl) == true else { return false }
        PhoneNumber.webView.loadRequest(URLRequest(url: phoneUrl))
        return true
    }

    fileprivate var components: [String]? {
        guard
            let one = number.substring(from: 0, to: 1),
            let area = number.substring(from: 1, to: 4),
            let part1 = number.substring(from: 4, to: 7),
            let part2 = number.substring(from: 7, to: 11)
            else
        { assertionFailure("Saved number was invalid! \(number)"); return nil }
        return [one, area, part1, part2]
    }
}
