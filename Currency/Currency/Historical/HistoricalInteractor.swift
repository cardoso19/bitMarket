//
//  HistoricalInteractor.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service
import Formatter

protocol HistoricalInteracting {
    func updateCurrentValue()
    func updateCriptoCurrencyHistoricalList()
}

final class HistoricalInteractor {
    // MARK: - Variables
    private let service: HistoricalServicing
    private let presenter: HistoricalPresenting
    private var currencyRates: Currencies?
    private var lastTodayValue: TodayCriptoCurrency?
    
    // MARK: - Life Cycle
    init(service: HistoricalServicing, presenter: HistoricalPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - HistoricalInteracting
extension HistoricalInteractor: HistoricalInteracting {
    // MARK: - CurrentValue
    func updateCurrentValue() {
        getCurrenValue { [weak self] todayValue in
            self?.presenter.presentCriptoTodayValue((Date(), todayValue.bpi.eur.rateFloat))
        }
    }
    
    private func getCurrenValue(completion: @escaping (TodayCriptoCurrency) -> Void) {
        service.getTodayCriptoCurrency { [weak self] result in
            switch result {
            case let .success(todayValue):
                self?.lastTodayValue = todayValue
                completion(todayValue)
            case let .failure(error):
                self?.presenter.presentError(message: error.localizedDescription)
            }
        }
    }
    // MARK: - Historical
    func updateCriptoCurrencyHistoricalList() {
        getCurrenValue { [weak self] todayValue in
            self?.getHistoricalAndRateValues(todayValue: todayValue)
        }
    }
    
    private func getHistoricalAndRateValues(todayValue: TodayCriptoCurrency) {
        guard currencyRates != nil else {
            currencyRatesRequest(todayValue: todayValue)
            return
        }
        
        guard
            let start = Calendar.current.date(byAdding: .day, value: -13, to: Date())?.toString(format: "yyyy-MM-dd"),
            let end = Calendar.current.date(byAdding: .day, value: -1, to: Date())?.toString(format: "yyyy-MM-dd")
            else {
                return
        }
        
        service.getCriptoCurrencyHistorical(fromDate: start, toDate: end) { [weak self] result in
            switch result {
            case let .success(historicalUSD):
                var historicalEUR = historicalUSD.bpi.compactMapValues({ self?.convert(value: $0, to: .eur) })
                historicalEUR[Date()] = todayValue.bpi.eur.rateFloat
                self?.presenter.presentCriptoCurrencyHistorical(historicalEUR)
            case let .failure(error):
                self?.presenter.presentError(message: error.localizedDescription)
            }
        }
    }
    
    private func currencyRatesRequest(todayValue: TodayCriptoCurrency) {
        service.getCurrencyRates(base: .usd) { [weak self] result in
            switch result {
            case let .success(currencyRates):
                self?.currencyRates = currencyRates
                self?.getHistoricalAndRateValues(todayValue: todayValue)
            case let .failure(error):
                self?.presenter.presentError(message: error.localizedDescription)
            }
        }
    }
    
    private func convert(value: Double, to currency: Currency) -> Double? {
        guard let currencyValue = currencyRates?.rates[currency] else { return nil }
        return value * currencyValue
    }
}
