//
//  DetailFactory.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 07/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Service

struct CriptoCurrency {
    let rates: [Currency: Double]
}

final class DetailFactory {
    static func make(criptoCurrency: CriptoCurrency, currencies: Currencies, date: Date) -> UIViewController {
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(
            presenter: presenter,
            criptoCurrency: criptoCurrency,
            currencies: currencies,
            date: date
        )
        let viewController = DetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
