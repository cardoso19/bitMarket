//
//  DateFormatterTests.swift
//  FormatterTests
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
@testable import Formatter

final class DateFormatterTests: XCTestCase {
    // MARK: - toString
    func testToString_ShouldFormatWithTheGivenFormat() {
        let date = Date.init(timeIntervalSince1970: 1583668800)
        let format = "dd/MM/yyyy"
        XCTAssertEqual(date.toString(format: format), "08/03/2020")
    }
}
