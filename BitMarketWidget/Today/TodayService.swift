//
//  TodayService.swift
//  BitMarketWidget
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Service

protocol TodayServicing {
    func getTodayCriptoCurrency(completion: @escaping (Result<TodayCriptoCurrency, RequestError>) -> Void)
}

final class TodayService {
    // MARK: - Variables
    private let queue: DispatchQueue
    private let requester: Requesting
    
    // MARK: - Life Cycle
    init(queue: DispatchQueue = .main, requester: Requesting) {
        self.queue = queue
        self.requester = requester
    }
}

// MARK: - TodayServicing
extension TodayService: TodayServicing {
    func getTodayCriptoCurrency(completion: @escaping (Result<TodayCriptoCurrency, RequestError>) -> Void) {
        requester.request(with: CriptoCurrencyRequest.current) { [weak self] result in
            self?.queue.async {
                completion(result)
            }
        }
    }
}
