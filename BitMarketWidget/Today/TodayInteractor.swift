//
//  TodayInteractor.swift
//  BitMarketWidget
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service

protocol TodayInteracting {
    func getCurrentValue()
}

final class TodayInteractor {
    // MARK: - Variables
    private let service: TodayServicing
    private let presenter: TodayPresenting
    
    // MARK: - Life Cycle
    init(service: TodayServicing, presenter: TodayPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - TodayInteracting
extension TodayInteractor: TodayInteracting {
    // MARK: - getCurrentValue
    func getCurrentValue() {
        service.getTodayCriptoCurrency { [weak self] result in
            self?.presenter.hideLoader()
            switch result {
            case let .success(todayValue):
                self?.presenter.presentValue(currency: .eur, value: todayValue.bpi.eur.rateFloat)
            case let .failure(error):
                self?.presenter.presentError(message: error.localizedDescription)
            }
        }
    }
}
