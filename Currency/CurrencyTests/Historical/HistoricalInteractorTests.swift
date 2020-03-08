//
//  HistoricalInteractorTests.swift
//  CurrencyTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
import Service
@testable import Currency

private final class HistoricalPresenterMock: HistoricalPresenting {
    private(set) var presentCriptoTodayValueCallCount = 0
    private(set) var presentCriptoCurrencyHistoricalCallCount = 0
    private(set) var presentErrorCallCount = 0
    private(set) var presentDetailCriptoCurrencyCallCount = 0
    private(set) var today: (date: Date, value: Double)?
    private(set) var historical: [Date : Double]?
    private(set) var criptoCurrency: CriptoCurrency?
    private(set) var currencies: Currencies?
    private(set) var date: Date?
    
    func presentCriptoTodayValue(_ today: (Date, Double)) {
        presentCriptoTodayValueCallCount += 1
        self.today = today
    }
    
    func presentCriptoCurrencyHistorical(_ historical: [Date : Double]) {
        presentCriptoCurrencyHistoricalCallCount += 1
        self.historical = historical
    }
    
    func presentError(message: String) {
        presentErrorCallCount += 1
    }
    
    func presentDetail(with criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date) {
        presentDetailCriptoCurrencyCallCount += 1
        self.criptoCurrency = criptoCurrency
        self.currencies = currencies
        self.date = date
    }
}

private final class HistoricalServiceMock: HistoricalServicing {
    var getCurrencyRatesResult: Result<Currencies, RequestError>?
    var getCriptoCurrencyHistorical: Result<CriptoCurrencyHistorical, RequestError>?
    var getTodayCriptoCurrency: Result<TodayCriptoCurrency, RequestError>?
    private(set) var getCurrencyRatesCallCount = 0
    private(set) var getCriptoCurrencyHistoricalCallCount = 0
    private(set) var getTodayCriptoCurrencyCallCount = 0
    
    func getCurrencyRates(base: Currency, completion: @escaping (Result<Currencies, RequestError>) -> Void) {
        getCurrencyRatesCallCount += 1
        guard let result = getCurrencyRatesResult else { return }
        completion(result)
    }
    
    func getCriptoCurrencyHistorical(fromDate start: String, toDate end: String, completion: @escaping (Result<CriptoCurrencyHistorical, RequestError>) -> Void) {
        getCriptoCurrencyHistoricalCallCount += 1
        guard let result = getCriptoCurrencyHistorical else { return }
        completion(result)
    }
    
    func getTodayCriptoCurrency(completion: @escaping (Result<TodayCriptoCurrency, RequestError>) -> Void) {
        getTodayCriptoCurrencyCallCount += 1
        guard let result = getTodayCriptoCurrency else { return }
        completion(result)
    }
}

final class HistoricalInteractorTests: XCTestCase {
    // MARK: - Variables
    private let service = HistoricalServiceMock()
    private let presenter = HistoricalPresenterMock()
    private lazy var interactor: HistoricalInteracting = HistoricalInteractor(service: service, presenter: presenter)
    
    // MARK: - updateCurrentValue
    func testUpdateCurrentValue_WhenReceivesError_ShouldCallPresentError() {
        service.getTodayCriptoCurrency = .failure(.unknown("Error"))
        interactor.updateCurrentValue()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(presenter.presentErrorCallCount, 1)
    }
    
    func testUpdateCurrentValue_WhenReceivesSuccess_ShoudlCallPresentCriptoTodayValueWithGivenData() {
        let todayString = Date().toString(format: "dd/MM/yyyy")
        let eur = 3.0
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: eur)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        interactor.updateCurrentValue()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(presenter.presentCriptoTodayValueCallCount, 1)
        XCTAssert(presenter.today?.date.toString(format: "dd/MM/yyyy") == todayString)
        XCTAssert(presenter.today?.value == eur)
    }
    
    // MARK: - updateCriptoCurrencyHistoricalList
    func testUpdateCriptoCurrencyHistoricalList_WhenReceivesErrorOnToday_ShouldCallPresentErrorAndNotGetCurrencyRates() {
        service.getTodayCriptoCurrency = .failure(.unknown("Error"))
        interactor.updateCriptoCurrencyHistoricalList()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(service.getCurrencyRatesCallCount, 0)
        XCTAssertEqual(presenter.presentErrorCallCount, 1)
    }
    
    func testUpdateCriptoCurrencyHistoricalList_WhenReceivesSuccessOnTodayAndFailureInCurrenciesRate_ShouldCallPresentErrorAndNotGetCriptoCurrencyHistorical() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .failure(.unknown("Error"))
        interactor.updateCriptoCurrencyHistoricalList()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(service.getCurrencyRatesCallCount, 1)
        XCTAssertEqual(service.getCriptoCurrencyHistoricalCallCount, 0)
        XCTAssertEqual(presenter.presentErrorCallCount, 1)
    }
    
    func testUpdateCriptoCurrencyHistoricalList_WhenReceivesSuccessOnTodayAndCurrenciesRateAndFailureInHistorical_ShouldCallPresentErrorAndNotPresentCriptoCurrencyHistorical() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let currencies = Currencies(rates: [
            .eur: 1.0,
            .gbp: 2.0
        ])
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .success(currencies)
        service.getCriptoCurrencyHistorical = .failure(.unknown("Error"))
        interactor.updateCriptoCurrencyHistoricalList()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(service.getCurrencyRatesCallCount, 1)
        XCTAssertEqual(service.getCriptoCurrencyHistoricalCallCount, 1)
        XCTAssertEqual(presenter.presentCriptoCurrencyHistoricalCallCount, 0)
        XCTAssertEqual(presenter.presentErrorCallCount, 1)
    }
    
    func testUpdateCriptoCurrencyHistoricalList_WhenReceivesSuccessOnAll_ShouldCallPresentCriptoCurrencyHistoricalAndNotPresentError() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let currencies = Currencies(rates: [
            .eur: 1.0,
            .gbp: 2.0
        ])
        let yesterdayValue = 10.0
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            XCTFail("Could not get the yesterday date")
            return
        }
        let historical = CriptoCurrencyHistorical(bpi: [yesterday: yesterdayValue])
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .success(currencies)
        service.getCriptoCurrencyHistorical = .success(historical)
        interactor.updateCriptoCurrencyHistoricalList()
        XCTAssertEqual(service.getTodayCriptoCurrencyCallCount, 1)
        XCTAssertEqual(service.getCurrencyRatesCallCount, 1)
        XCTAssertEqual(service.getCriptoCurrencyHistoricalCallCount, 1)
        XCTAssertEqual(presenter.presentCriptoCurrencyHistoricalCallCount, 1)
        XCTAssertEqual(presenter.presentErrorCallCount, 0)
        XCTAssert(presenter.historical?.count == 2)
        XCTAssert(presenter.historical?[yesterday] == yesterdayValue)
    }
    
    // MARK: - detailSelection
    func testDetailSelection_WhenLastTodayValueIsNil_ShouldNotCallPresentDetail() {
        let indexPath = IndexPath(row: 0, section: 0)
        interactor.detailSelection(indexPath: indexPath)
        XCTAssertEqual(presenter.presentDetailCriptoCurrencyCallCount, 0)
    }
    
    func testDetailSelection_WhenLastTodayValueIsNotNilAndCurrenciesIsNil_ShouldNotCallPresentDetail() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let indexPath = IndexPath(row: 0, section: 0)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .failure(.unknown("Error"))
        interactor.updateCriptoCurrencyHistoricalList()
        interactor.detailSelection(indexPath: indexPath)
        XCTAssertEqual(presenter.presentDetailCriptoCurrencyCallCount, 0)
    }
    
    func testDetailSelection_WhenLastTodayValueAndCurrenciesIsNotNilAndHistoricalIsNil_ShouldNotCallPresentDetail() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let currencies = Currencies(rates: [
            .eur: 1.0,
            .gbp: 2.0
        ])
        let indexPath = IndexPath(row: 0, section: 0)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .success(currencies)
        service.getCriptoCurrencyHistorical = .failure(.unknown("Error"))
        interactor.updateCriptoCurrencyHistoricalList()
        interactor.detailSelection(indexPath: indexPath)
        XCTAssertEqual(presenter.presentDetailCriptoCurrencyCallCount, 0)
    }
    
    func testDetailSelection_WhenLastTodayValueAndCurrenciesAndHistoricalIsNotNilAndFirstIndexIsSelected_ShouldCallPresentDetailWithUsdAndEurAndGbpValues() {
        let todayString = Date().toString(format: "dd/MM/yyyy")
        let usd = 1.0
        let gbp = 2.0
        let eur = 3.0
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: usd),
            gbp: CriptoCurrencyRate(rateFloat: gbp),
            eur: CriptoCurrencyRate(rateFloat: eur)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let currencies = Currencies(rates: [
            .eur: 1.0,
            .gbp: 2.0
        ])
        let yesterdayValue = 10.0
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            XCTFail("Could not get the yesterday date")
            return
        }
        let historical = CriptoCurrencyHistorical(bpi: [yesterday: yesterdayValue])
        let indexPath = IndexPath(row: 0, section: 0)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .success(currencies)
        service.getCriptoCurrencyHistorical = .success(historical)
        interactor.updateCriptoCurrencyHistoricalList()
        interactor.detailSelection(indexPath: indexPath)
        XCTAssertEqual(presenter.presentDetailCriptoCurrencyCallCount, 1)
        XCTAssertNotNil(presenter.currencies)
        XCTAssert(presenter.criptoCurrency?.rates[.usd] == usd)
        XCTAssert(presenter.criptoCurrency?.rates[.eur] == eur)
        XCTAssert(presenter.criptoCurrency?.rates[.gbp] == gbp)
        XCTAssert(presenter.date?.toString(format: "dd/MM/yyyy") == todayString)
    }
    
    func testDetailSelection_WhenLastTodayValueAndCurrenciesAndHistoricalIsNotNilAndInsteadOfFirstIndexAnotherIsSelected_ShouldCallPresentDetailWithUsdValue() {
        let bpi = Bpi(
            usd: CriptoCurrencyRate(rateFloat: 1.0),
            gbp: CriptoCurrencyRate(rateFloat: 2.0),
            eur: CriptoCurrencyRate(rateFloat: 3.0)
        )
        let todayCriptoCurrency = TodayCriptoCurrency(bpi: bpi)
        let currencies = Currencies(rates: [
            .eur: 1.0,
            .gbp: 2.0
        ])
        let yesterdayValue = 10.0
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            XCTFail("Could not get the yesterday date")
            return
        }
        let historical = CriptoCurrencyHistorical(bpi: [yesterday: yesterdayValue])
        let indexPath = IndexPath(row: 0, section: 1)
        service.getTodayCriptoCurrency = .success(todayCriptoCurrency)
        service.getCurrencyRatesResult = .success(currencies)
        service.getCriptoCurrencyHistorical = .success(historical)
        interactor.updateCriptoCurrencyHistoricalList()
        interactor.detailSelection(indexPath: indexPath)
        XCTAssertEqual(presenter.presentDetailCriptoCurrencyCallCount, 1)
        XCTAssertNotNil(presenter.currencies)
        XCTAssert(presenter.criptoCurrency?.rates[.usd] == yesterdayValue)
        XCTAssertNil(presenter.criptoCurrency?.rates[.eur])
        XCTAssertNil(presenter.criptoCurrency?.rates[.gbp])
        XCTAssert(presenter.date == yesterday)
    }
}
