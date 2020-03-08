//
//  HistoricalRouter.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Service

protocol HistoricalRouting {
    func routeDetail(with criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date)
}

final class HistoricalRouter {
    // MARK: - Variables
    weak var viewController: UIViewController?
}

// MARK: - HistoricalRouting
extension HistoricalRouter: HistoricalRouting {
    func routeDetail(with criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date) {
        let detailController = DetailFactory.make(criptoCurrency: criptoCurrency, currencies: currencies, date: date)
        viewController?.navigationController?.pushViewController(detailController, animated: true)
    }
}
