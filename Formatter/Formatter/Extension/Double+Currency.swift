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
    /// - Parameter hasCurrencySymbol: Define if the currency symbol will appear and the punctuation structure.
    public func convert(withLocale locale: String, hasCurrencySymbol: Bool = true) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        if !hasCurrencySymbol {
            formatter.locale = Locale(identifier: "de_DE")
            formatter.currencySymbol = ""
        }
        return formatter.string(from: self as NSNumber)
    }
}
