//
//  HistoricalPresenter.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

protocol HistoricalPresenting {
    
}

final class HistoricalPresenter {
    // MARK: - Variables
    weak var viewController: HistoricalDisplay?
    private var router: HistoricalRouting
    
    // MARK: - Life Cycle
    init(router: HistoricalRouting) {
        self.router = router
    }
}

// MARK: - HistoricalPresenting
extension HistoricalPresenter: HistoricalPresenting {
    
}
