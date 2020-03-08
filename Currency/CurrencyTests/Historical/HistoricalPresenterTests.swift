//
//  HistoricalPresenterTests.swift
//  CurrencyTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
import Service
import Formatter
@testable import Currency

private final class HistoricalViewControllerMock: HistoricalDisplay {
    private(set) var displayTodayValueCallCount = 0
    private(set) var displayHistoricalCallCount = 0
    private(set) var displayErrorCallCount = 0
    private(set) var today: (date: String, value: String)?
    private(set) var list: [(date: String, value: String)]?
    private(set) var message: String?
    
    func displayTodayValue(today: (String, String)) {
        displayTodayValueCallCount += 1
        self.today = today
    }
    
    func displayHistorical(list: [(String, String)]) {
        displayHistoricalCallCount += 1
        self.list = list
    }
    
    func displayError(message: String) {
        displayErrorCallCount += 1
        self.message = message
    }
}

private final class HistoricalRouterMock: HistoricalRouting {
    private(set) var routeDetailCallCount = 0
    private(set) var criptoCurrency: CriptoCurrency?
    private(set) var currencies: Currencies?
    private(set) var date: Date?
    
    func routeDetail(with criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date) {
        routeDetailCallCount += 1
        self.criptoCurrency = criptoCurrency
        self.currencies = currencies
        self.date = date
    }
}

final class HistoricalPresenterTests: XCTestCase {
    // MARK: - Variables
    private let viewController = HistoricalViewControllerMock()
    private let router = HistoricalRouterMock()
    private lazy var presenter: HistoricalPresenting = {
        let presenter = HistoricalPresenter(router: router)
        presenter.viewController = viewController
        return presenter
    }()
    
    // MARK: - presentCriptoTodayValue
    func testPresentCriptoTodayValue_ShouldCallDisplayTodayValueWithGivenDataFormatted() {
        let date = Date()
        let value = 1.0
        let today = (date, value)
        presenter.presentCriptoTodayValue(today)
        XCTAssertEqual(viewController.displayTodayValueCallCount, 1)
        XCTAssert(viewController.today?.date == date.toString(format: "dd/MM/yyyy"))
        XCTAssert(viewController.today?.value == value.convert(withLocale: Currency.eur.locale))
    }
    
    // MARK: - presentCriptoCurrencyHistorical
    func testPresentCriptoCurrencyHistorical_ShouldCallDisplayHistoricalWithGivenDataFormatted() {
        let date = Date()
        let value = 1.0
        let historical = [date: value]
        presenter.presentCriptoCurrencyHistorical(historical)
        XCTAssertEqual(viewController.displayHistoricalCallCount, 1)
        XCTAssert(viewController.list?.first?.date == date.toString(format: "dd/MM/yyyy"))
        XCTAssert(viewController.list?.first?.value == value.convert(withLocale: Currency.eur.locale))
    }
    
    // MARK: - presentError
    func testPresentError_ShouldCallDisplayErrorWithTheGivenData() {
        let message = "Test"
        presenter.presentError(message: message)
        XCTAssertEqual(viewController.displayErrorCallCount, 1)
        XCTAssert(viewController.message == message)
    }
    
    // MARK: - presentDetail
    func testPresentDetail_ShouldCallRouteDetailWithTheGivenData() {
        let criptoCurrency = CriptoCurrency(rates: [.usd: 1.0])
        let currencies = Currencies(rates: [.eur: 2.0])
        let date = Date()
        presenter.presentDetail(with: criptoCurrency, currencies: currencies, date: date)
        XCTAssertEqual(router.routeDetailCallCount, 1)
        XCTAssertNotNil(router.criptoCurrency)
        XCTAssertNotNil(router.currencies)
        XCTAssert(router.date == date)
    }
}
