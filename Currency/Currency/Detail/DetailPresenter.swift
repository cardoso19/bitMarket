//
//  DetailPresenter.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 07/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service
import Formatter

protocol DetailPresenting {
    func presentDay(_ day: Date)
    func presentList(_ list: [(Currency, Double)])
}

final class DetailPresenter {
    // MARK: - Variables
    weak var viewController: DetailDisplay?
}

// MARK: - DetailPresenting
extension DetailPresenter: DetailPresenting {
    func presentDay(_ day: Date) {
        viewController?.display(day: day.toString(format: "dd/MM/yyyy"))
    }
    
    func presentList(_ list: [(Currency, Double)]) {
        let formattedList = list.compactMap { (currency, value) -> (String, String)? in
            let currencyText = currency.rawValue
            guard let currencyValue = value.convert(withLocale: currency.locale, hasCurrencySymbol: false) else {
                return nil
            }
            return (currencyText, currencyValue)
        }
        viewController?.displayList(currencies: formattedList)
    }
}
