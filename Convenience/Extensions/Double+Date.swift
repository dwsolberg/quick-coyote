//
//  Double+Date.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

/// Epoch dates are stored as Doubles - time in seconds since the beginning of 1970. These methods provide convenience methods to get and show dates assuming epoch numbers.
extension Double {
    
    static let dateMediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let dateShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    static let dateTimeShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var date: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var dateMediumString: String {
        return Double.dateMediumFormatter.string(from: self.date)
    }
    
    var dateShortString: String {
        return Double.dateShortFormatter.string(from: self.date)
    }

    var dateTimeShortString: String {
        return Double.dateTimeShortFormatter.string(from: self.date)
    }
}

extension Date {
    
    var double: Double {
        return self.timeIntervalSince1970
    }
}
