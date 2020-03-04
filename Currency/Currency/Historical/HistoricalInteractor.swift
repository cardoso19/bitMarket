//
//  HistoricalInteractor.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Network
import Formatter

protocol HistoricalInteracting {
    func updateCriptoCurrencyHistoricalList()
}

final class HistoricalInteractor {
    // MARK: - Variables
    private let service: HistoricalServicing
    private let presenter: HistoricalPresenting
    private var currencyRates: Currencies?
    
    // MARK: - Life Cycle
    init(service: HistoricalServicing, presenter: HistoricalPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - HistoricalInteracting
extension HistoricalInteractor: HistoricalInteracting {
    // MARK: - Historical
    func updateCriptoCurrencyHistoricalList() {
        guard currencyRates != nil else {
            currencyRatesRequest()
            return
        }
        let start = Date().toString(format: "yyyy-MM-dd")
        let end = Date().toString(format: "yyyy-MM-dd")
        service.getCriptoCurrencyHistorical(fromDate: start, toDate: end) { [weak self] result in
            switch result {
            case let .success(historicalUSD):
                let historicalEUR = historicalUSD.bpi.compactMapValues({ self?.convert(value: $0, to: .eur) })
                self?.presenter.presentCriptoCurrencyHistorical(historicalEUR)
            case .failure:
                // TODO: - Present alert error
                break
            }
        }
    }
    
    private func currencyRatesRequest() {
        service.getCurrencyRates(base: .usd) { [weak self] result in
            switch result {
            case let .success(currencyRates):
                self?.currencyRates = currencyRates
                self?.updateCriptoCurrencyHistoricalList()
            case .failure:
                // TODO: - Present alert error
                break
            }
        }
    }
    
    private func convert(value: Double, to currency: Currency) -> Double? {
        guard let currencyValue = currencyRates?.rates[currency] else { return nil }
        return value * currencyValue
    }
}
