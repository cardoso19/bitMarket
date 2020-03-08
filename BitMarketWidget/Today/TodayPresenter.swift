//
//  TodayPresenter.swift
//  BitMarketWidget
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service
import Formatter

protocol TodayPresenting {
    func presentValue(currency: Currency, value: Double)
    func hideLoader()
    func presentError(message: String)
}

final class TodayPresenter {
    // MARK: - Variables
    weak var viewController: TodayDisplay?
}

// MARK: - TodayPresenting
extension TodayPresenter: TodayPresenting {
    func presentValue(currency: Currency, value: Double) {
        let title = "1 Btc"
        guard let value = value.convert(withLocale: currency.locale) else {
            return
        }
        viewController?.display(title: title, value: value)
    }
    
    func hideLoader() {
        viewController?.hideLoader()
    }
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
}
