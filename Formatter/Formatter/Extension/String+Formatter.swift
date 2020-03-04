//
//  String+Formatter.swift
//  Formatter
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

extension String {
    /// Convert a String to a Date.
    /// - Parameter format: The date format of the string.
    public func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}
