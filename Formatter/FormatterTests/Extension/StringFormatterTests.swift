//
//  StringFormatterTests.swift
//  FormatterTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest

final class StringFormatterTests: XCTestCase {
    // MARK: - toDate
    func testToDate_WhenStringCorrectAndMatchWithFormat_ShouldFormatToDate() {
        let dateString = "25/12/2020"
        let format = "dd/MM/yyyy"
        XCTAssertNotNil(dateString.toDate(format: format))
    }
    
    func testToDate_WhenStringIncorrectAndMatchWithFormat_ShouldNotFormatToDate() {
        let dateString = "2a/12/asdd"
        let format = "dd/MM/yyyy"
        XCTAssertNil(dateString.toDate(format: format))
    }
    
    func testToDate_WhenStringCorrectAndUnmatchWithFormat_ShouldNotFormatToDate() {
        let dateString = "25/12/2020"
        let format = "yyyy/MM/ddd"
        XCTAssertNil(dateString.toDate(format: format))
    }
    
    func testToDate_WhenStringIncorrectAndUnmatchWithFormat_ShouldNotFormatToDate() {
        let dateString = "asxv/asdf"
        let format = "yyyy/MM/ddd"
        XCTAssertNil(dateString.toDate(format: format))
    }
}
