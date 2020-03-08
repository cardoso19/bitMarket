//
//  DoubleCurrenciyTests.swift
//  FormatterTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
@testable import Formatter

final class DoubleCurrenciyTests: XCTestCase {
    // MARK: - convert
    func testConvert_WhenLocaleIsValidAndHasCurrencySymbolIsTrue_ShouldReturnFormatedValue() {
        let value = 1000.0
        let locale = "en_US"
        XCTAssert(value.convert(withLocale: locale, hasCurrencySymbol: true) == "$1,000.00")
    }
    
    func testConvert_WhenLocaleIsValidAndHasCurrencySymbolIsFalse_ShouldReturnFormatedValueWithout() {
        let value = 1000.0
        let locale = "en_US"
        XCTAssert(value.convert(withLocale: locale, hasCurrencySymbol: false) == "1.000,00 ")
    }
    
    func testConvert_WhenLocaleIsInvalid_ShouldReturnFormatedValueWithUnkownCurrencySymbol() {
        let value = 1000.0
        let locale = "test"
        XCTAssert(value.convert(withLocale: locale) == "¤ 1000.00")
    }
}
