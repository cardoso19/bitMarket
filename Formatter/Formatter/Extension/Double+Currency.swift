//
//  Double+Currency.swift
//  Formatter
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

extension Double {
    /// Convert the value to a currency value.
    /// - Parameter locale: The currency's locale.
    public func convert(withLocale locale: String) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
