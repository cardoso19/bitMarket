//
//  HistoricalService.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Network

protocol HistoricalServicing {
    func getCurrencyRates(base: Currency, completion: @escaping (Result<Currencies, RequestError>) -> Void)
    func getCriptoCurrencyHistorical(fromDate start: String, toDate end: String, completion: @escaping (Result<CriptoCurrencyHistorical, RequestError>) -> Void)
}

final class HistoricalService {
    // MARK: - Variables
    private let queue: DispatchQueue
    private let requester: Requesting
    
    // MARK: - Life Cycle
    init(queue: DispatchQueue = DispatchQueue.main, requester: Requesting) {
        self.queue = queue
        self.requester = requester
    }
}

// MARK: - HistoricalServicing
extension HistoricalService: HistoricalServicing {
    func getCurrencyRates(base: Currency, completion: @escaping (Result<Currencies, RequestError>) -> Void) {
        requester.request(with: CurrencyRateRequest.rate(base)) { [weak self] result in
            self?.queue.async {
                completion(result)
            }
        }
    }
    
    func getCriptoCurrencyHistorical(fromDate start: String, toDate end: String, completion: @escaping (Result<CriptoCurrencyHistorical, RequestError>) -> Void) {
        requester.request(with: CriptoCurrencyRequest.list(start, end)) { [weak self] result in
            self?.queue.async {
                completion(result)
            }
        }
    }
}
