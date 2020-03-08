//
//  UIColorExtensionsTests.swift
//  ResourcesTests
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
@testable import Resources

final class UIColorExtensionsTests: XCTestCase {
    // MARK: - primary
    func testPrimary_ShouldNotBeNil() {
        XCTAssertNotNil(UIColor.primary)
    }
    
    // MARK: - secondary
    func testSecondary_ShouldNotBeNil() {
        XCTAssertNotNil(UIColor.secondary)
    }
    
    // MARK: - primary
    func testTertiary_ShouldNotBeNil() {
        XCTAssertNotNil(UIColor.tertiary)
    }
    
    // MARK: - primary
    func testQuaternary_ShouldNotBeNil() {
        XCTAssertNotNil(UIColor.quaternary)
    }
}
