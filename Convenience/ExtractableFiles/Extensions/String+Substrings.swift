//
//  String+Substrings.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

/// Based on http://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift-3/39677704#39677704
/// More explanation on Swift 3: https://oleb.net/blog/2016/09/swift-3-ranges/

// WTF Warning for Emoji as of Swift 3:
// let flags = "🇼🇫🇹🇼🇻🇪🇹🇹"
// let first = flags.substring(to: 1) -> shows all the flags in a row "🇼🇫🇹🇼🇻🇪🇹🇹"

// let thumb = "👍🏽"
// let first = thumb.substring(to: 1) -> shows the "normal" thumb "👍"
// let second = thumb.substring(from: 1) -> shows the thumb color "🏽"

extension String {

    /**
     Creates a substring from the character index to the end of the string. If a character is made of two parts (for example, an e followed accent mark), it will treat the two components as one, so in normal circumstances, you'll get what you expect.

     However, in Swift 3, emojis are often treated differently. For example, a smiling face with a medium skin tone is treated as two characters: a smiling face plus a color.

     - parameter from: the start character index

     - returns: A substring if the index is in bounds. Otherwise, nil.
     */
    func substring(from: Int) -> String? {
        guard let fromIndex = index(at: from) else { return nil }
        return substring(from: fromIndex)
    }

    /**
     Creates a substring from the start of the string to the to character index. If a character is made of two parts (for example, an e followed accent mark), it will treat the two components as one, so in normal circumstances, you'll get what you expect.

     However, in Swift 3, emojis are often treated differently. For example, a smiling face with a medium skin tone is treated as two characters: a smiling face plus a color.

     - parameter to: the end character index

     - returns: A substring if the index is in bounds. Otherwise, nil.
     */
    func substring(to: Int) -> String? {
        guard let toIndex = index(at: to) else { return nil }
        return substring(to: toIndex)
    }

    /**
     Creates a substring using the character index. If a character is made of two parts (for example, an e followed accent mark), it will treat the two components as one, so in normal circumstances, you'll get what you expect.
     
     However, in Swift 3, emojis are often treated differently. For example, a smiling face with a medium skin tone is treated as two characters: a smiling face plus a color.

     - parameter from: the start character index
     - parameter to: the end character index

     - returns: A substring if both indices are in bounds. Otherwise, nil.
     */
    func substring(from: Int, to: Int) -> String? {
        guard let startIndex = index(at: from) else { return nil }
        guard let endIndex = index(at: to) else { return nil }
        return substring(with: startIndex..<endIndex)
    }


    // MARK: - Private

    fileprivate func index(at: Int) -> Index? {
        return self.index(startIndex, offsetBy: at, limitedBy: endIndex)
    }
}
