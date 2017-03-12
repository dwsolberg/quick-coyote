//
//  JsonFormatting.swift
//  Convenience
//
//  Created by David Solberg on 2/25/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

/// Prints the Array or Dictionary as formatted JSON if possible.
///
/// - Parameter json: An Array or Dictionary that can be represented as JSON
func printAsJSON(_ json: Any) {
    if let dictionary = json as? [String: Any?] {
        print(dictionary.asJSON)
    } else if let array = json as? [Any] {
        print (array.asJSON)
    }
}

/// Allows JSON formatting of dictionaries if they conform.
extension Dictionary {

    var asJSON: String {
        if let formatter = JSONFormatter(withJSON: self) {
            return formatter.json
        } else {
            return "Invalid JSON"
        }
    }

    var asJSONAttributed: NSAttributedString {
        if let formatter = JSONFormatter(withJSON: self) {
            return formatter.jsonAttributed
        } else {
            return NSAttributedString(string: "Invalid JSON")
        }
    }
}

/// Allows JSON formatting of arrays if they conform.
extension Array {
    var asJSON: String {
        if let formatter = JSONFormatter(withJSON: self) {
            return formatter.json
        } else {
            return "Invalid JSON"
        }
    }
    var asJSONAttributed: NSAttributedString {
        if let formatter = JSONFormatter(withJSON: self) {
            return formatter.jsonAttributed
        } else {
            return NSAttributedString(string: "Invalid JSON")
        }
    }
}

// Allows QuickLook to work in the playground
extension Dictionary: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.attributedString(self.asJSONAttributed)
    }
}

// Allows QuickLook to work in the playground
extension Array: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.attributedString(self.asJSONAttributed)
    }
}

/// If you want to view QuickLook objects in Xcode, you need to box the object first. This is because Dictionary and Array cannot have QuickLook objects added to them. In the playground, QuickLook works because they can conform to the CustomPlaygroundQuickLookable protocol.
@objc class JSONBox: NSObject {
    private let JSON: Any

    init(_ json: Any) {
        self.JSON = json
    }

    /// debugQuickLookObject
    ///
    /// - Returns: An attributed string representing the array or dictionary as JSON.
    public func debugQuickLookObject() -> AnyObject? {
        if let dictionary = JSON as? [String: Any?] {
            return dictionary.asJSONAttributed
        } else if let array = JSON as? [Any] {
            return array.asJSONAttributed
        } else {
            return nil
        }
    }
}

// This class formats a dictionary or array as json. It also adds color formatting in an attributed string for QuickLook.
class JSONFormatter {

    let json: String

    var jsonAttributed: NSAttributedString {
        return highlight(json: json)
    }

    init?(withJSON json: Any) {
        guard JSONSerialization.isValidJSONObject(json),
            let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let string = String(data: data, encoding: String.Encoding.utf8)
            else { return nil }
        self.json = string
    }

    // MARK: - Private Variables

    // Based off of https://github.com/bahamas10/JSONSyntaxHighlight but in Swift so we don't need to deal with bridging headers.
    fileprivate let regex = try! NSRegularExpression(pattern: "^( *)(\".+\" : )?(\"[^\"]*\"|[\\w.+-]*)?([,\\[\\]{}]?,?$)", options: .anchorsMatchLines)

    fileprivate let nonStringAttributes = [NSForegroundColorAttributeName: UIColor(red: 31.0/255.0, green: 74.0/255.0, blue: 122.0/255.0, alpha: 1.0)]
    fileprivate let standardAttributes = [NSForegroundColorAttributeName: UIColor.black]
    fileprivate let stringAttributes = [NSForegroundColorAttributeName: UIColor(red: 34.0/255.0, green: 114.0/255.0, blue: 68.0/255.0, alpha: 1.0)]
    fileprivate let keyAttributes = [NSForegroundColorAttributeName: UIColor(red: 173.0/255.0, green: 38.0/255.0, blue: 24.0/255.0, alpha: 1.0)]

    // MARK: - Private Methods

    fileprivate typealias TextChangeBlock = (_ range: NSRange, _ string: String) -> Void

    /// highlights the json
    ///
    /// - Parameter jsonToHighlight: the json string with returns and spaces included
    /// - Returns: An attributed string with color highlights for viewing
    fileprivate func highlight(json jsonToHighlight: String) -> NSMutableAttributedString {
        let line = NSMutableAttributedString(string: "")

        let indentBlock: TextChangeBlock = { [unowned self] (range, string) in
            let indented = NSAttributedString(string: string, attributes: self.standardAttributes)
            line.append(indented)
        }

        let keyBlock: TextChangeBlock = { [unowned self] (range, string) in
            // Changes `"key" : ` to `"key"`
            let endIndex = string.index(string.endIndex, offsetBy: -3)
            let clipped = string.substring(to: endIndex)
            let key = NSAttributedString(string: clipped, attributes: self.keyAttributes)
            line.append(key)
            let colon = NSAttributedString(string: " : ", attributes: self.standardAttributes)
            line.append(colon)
        }

        let valueBlock: TextChangeBlock = { [unowned self] (range, string) in
            let attributes: Dictionary<String,Any>
            if let _ = string.range(of: "\"") {
                attributes = self.stringAttributes
            } else {
                attributes = self.nonStringAttributes
            }
            let valueString = NSAttributedString(string: string, attributes: attributes)
            line.append(valueString)
        }

        let endBlock: TextChangeBlock = { [unowned self] (range, string) in
            let valueString = NSAttributedString(string: string + "\n", attributes: self.standardAttributes)
            line.append(valueString)
        }

        enumerateMatches(inString: jsonToHighlight, indentBlock: indentBlock, keyBlock: keyBlock, valueBlock: valueBlock, endBlock: endBlock)
        
        return line
    }

    /// Using a regex, evaluates the JSON and formats according to the supplied action closures
    ///
    /// - Parameters:
    ///   - string: the json string with returns and spaces included
    ///   - indentBlock: action for indents
    ///   - keyBlock: action for json keys
    ///   - valueBlock: actions for json values
    ///   - endBlock: action for ending of json
    fileprivate func enumerateMatches(inString string: String, indentBlock: TextChangeBlock, keyBlock: TextChangeBlock, valueBlock: TextChangeBlock, endBlock: TextChangeBlock) {

        // Using Obj-C functions, so we're going to keep everything in the same language.
        let objCString = string as NSString
        regex.enumerateMatches(in: string, options: [], range: NSMakeRange(0, objCString.length)) { (match, flags, stop) in

            if let indentRange: NSRange = match?.rangeAt(1), indentRange.location != NSNotFound {
                indentBlock(indentRange, objCString.substring(with: indentRange))
            }

            if let keyRange: NSRange = match?.rangeAt(2), keyRange.location != NSNotFound  {
                keyBlock(keyRange, objCString.substring(with: keyRange))
            }

            if let valueRange: NSRange = match?.rangeAt(3), valueRange.location != NSNotFound  {
                valueBlock(valueRange, objCString.substring(with: valueRange))
            }

            if let endRange: NSRange = match?.rangeAt(4), endRange.location != NSNotFound  {
                endBlock(endRange, objCString.substring(with: endRange))
            }
        }
    }
}

