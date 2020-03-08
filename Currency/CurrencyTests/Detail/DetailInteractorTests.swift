//
//  CurrencyTests.swift
//  CurrencyTests
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
import Service
@testable import Currency

private final class DetailPresenterMock: DetailPresenting {
    private(set) var presentDayCallCount = 0
    private(set) var presentListCallCount = 0
    private(set) var day: Date?
    private(set) var list: [(currency: Currency, value: Double)]?
    
    func presentDay(_ day: Date) {
        presentDayCallCount += 1
        self.day = day
    }
    
    func presentList(_ list: [(Currency, Double)]) {
        presentListCallCount += 1
        self.list = list
    }
}

final class DetailInteractorTests: XCTestCase {
    // MARK: - Variables
    private let presenter = DetailPresenterMock()
    private var date = Date()
    private var criptoCurrency = CriptoCurrency(rates: [:])
    private var currencies = Currencies(rates: [:])
    private lazy var interactor: DetailInteracting = DetailInteractor(
        presenter: presenter,
        criptoCurrency: criptoCurrency,
        currencies: currencies,
        date: date
    )
    
    // MARK: - showData
    func testShowData_WhenReceviesOnlyUSDCriptoValue_ShouldCallPresentDayAndListWithGivenDataAndConvertedValuesToEURAndGBP() {
        let date = Date()
        self.date = date
        let usd = 1.0
        let eurValue = 2.0
        let gbpValue = 3.0
        criptoCurrency = CriptoCurrency(rates: [.usd: usd])
        currencies = Currencies(rates: [.eur: eurValue, .gbp: gbpValue])
        interactor.showData()
        XCTAssertEqual(presenter.presentDayCallCount, 1)
        XCTAssertEqual(presenter.presentListCallCount, 1)
        XCTAssert(presenter.day == date)
        XCTAssert(presenter.list?[0].currency == .eur)
        XCTAssert(presenter.list?[0].value == usd * eurValue)
        XCTAssert(presenter.list?[1].currency == .gbp)
        XCTAssert(presenter.list?[1].value == usd * gbpValue)
        XCTAssert(presenter.list?[2].currency == .usd)
        XCTAssert(presenter.list?[2].value == usd )
    }
    
    func testShowData_WhenReceivesUSDAndEURAndGBP_ShouldCallPresentDayAndListWithGivenData() {
        let date = Date()
        self.date = date
        let usd = 1.0
        let eur = 2.0
        let gbp = 3.0
        criptoCurrency = CriptoCurrency(rates: [
            .usd: usd,
            .eur: eur,
            .gbp: gbp
        ])
        interactor.showData()
        XCTAssertEqual(presenter.presentDayCallCount, 1)
        XCTAssertEqual(presenter.presentListCallCount, 1)
        XCTAssert(presenter.day == date)
        XCTAssert(presenter.list?[0].currency == .eur)
        XCTAssert(presenter.list?[0].value == eur)
        XCTAssert(presenter.list?[1].currency == .gbp)
        XCTAssert(presenter.list?[1].value == gbp)
        XCTAssert(presenter.list?[2].currency == .usd)
        XCTAssert(presenter.list?[2].value == usd )
    }
}
