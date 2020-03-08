//
//  DetailPresenterTests.swift
//  CurrencyTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
import Formatter
import Service
@testable import Currency

private final class DetailViewControllerMock: DetailDisplay {
    private(set) var displayDayCallCount = 0
    private(set) var displayListCallCount = 0
    private(set) var day: String?
    private(set) var currencies: [(title: String, value: String)]?
    
    func display(day: String) {
        displayDayCallCount += 1
        self.day = day
    }
    
    func displayList(currencies: [(String, String)]) {
        displayListCallCount += 1
        self.currencies = currencies
    }
}

final class DetailPresenterTests: XCTestCase {
    // MARK: - Variables
    private let viewController = DetailViewControllerMock()
    private lazy var presenter: DetailPresenting = {
        let presenter = DetailPresenter()
        presenter.viewController = viewController
        return presenter
    }()
    
    // MARK: - presentDay
    func testPresentDay_ShouldCallDisplayDayWithTheGivenData() {
        let date = Date()
        presenter.presentDay(date)
        XCTAssertEqual(viewController.displayDayCallCount, 1)
        XCTAssert(viewController.day == date.toString(format: "dd/MM/yyyy"))
    }
    
    // MARK: - presentList
    func testPresentList_ShouldCallDisplayListWithGivenDataFormatted() {
        let value = 1.0
        let currency = Currency.usd
        let formattedValue = value.convert(withLocale: currency.locale, hasCurrencySymbol: false)
        let list: [(Currency, Double)] = [(currency, value)]
        presenter.presentList(list)
        XCTAssertEqual(viewController.displayListCallCount, 1)
        XCTAssert(viewController.currencies?[0].title == currency.rawValue)
        XCTAssert(viewController.currencies?[0].value == formattedValue)
    }
}
