//
//  Double+Date.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

/// Epoch dates are stored as Doubles - time in seconds since the beginning of 1970. These methods provide convenience methods to get and show dates assuming epoch numbers.
extension Double {

    var date: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var dateMediumString: String {
        return date.mediumString
    }
    
    var dateShortString: String {
        return date.shortString
    }

    var dateTimeShortString: String {
        return date.shortStringWithTime
    }
}

extension Date {
    
    var double: Double {
        return self.timeIntervalSince1970
    }

    var mediumString: String {
        return Date.dateMediumFormatter.string(from: self)
    }

    var shortString: String {
        return Date.dateShortFormatter.string(from: self)
    }

    var shortStringWithTime: String {
        return Date.dateTimeShortFormatter.string(from: self)
    }

    fileprivate static let dateMediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    fileprivate static let dateShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    fileprivate static let dateTimeShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
