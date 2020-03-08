//
//  DetailInteractor.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 07/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service

protocol DetailInteracting {
    func showData()
}

final class DetailInteractor {
    // MARK: - Variables
    private let presenter: DetailPresenting
    private let criptoCurrency: CriptoCurrency
    private let currencies: Currencies
    private let date: Date
    
    // MARK: - Life Cycle
    init(presenter: DetailPresenting, criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date) {
        self.presenter = presenter
        self.criptoCurrency = criptoCurrency
        self.currencies = currencies
        self.date = date
    }
}

// MARK: - DetailInteracting
extension DetailInteractor: DetailInteracting {
    func showData() {
        presenter.presentDay(date)
        presenter.presentList(createList())
    }
    
    private func convert(value: Double, to currency: Currency) -> Double? {
        guard let currencyValue = currencies.rates[currency] else { return nil }
        return value * currencyValue
    }
    
    private func createList() -> [(Currency, Double)] {
        var list: [(Currency, Double)] = []
        guard let usd = criptoCurrency.rates[.usd] else {
            return []
        }
        if let eurValue = criptoCurrency.rates[.eur] {
            list.append((.eur, eurValue))
        } else if let eurValue = convert(value: usd, to: .eur) {
            list.append((.eur, eurValue))
        }
        if let gbpValue = criptoCurrency.rates[.gbp] {
            list.append((.gbp, gbpValue))
        } else if let gbpValue = convert(value: usd, to: .gbp) {
            list.append((.gbp, gbpValue))
        }
        list.append((.usd, usd))
        return list
    }
}
