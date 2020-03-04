//
//  HistoricalInteractor.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

protocol HistoricalInteracting {
    
}

final class HistoricalInteractor {
    // MARK: - Variables
    private let service: HistoricalServicing
    private let presenter: HistoricalPresenting
    
    // MARK: - Life Cycle
    init(service: HistoricalServicing, presenter: HistoricalPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - HistoricalInteracting
extension HistoricalInteractor: HistoricalInteracting {
    
}
