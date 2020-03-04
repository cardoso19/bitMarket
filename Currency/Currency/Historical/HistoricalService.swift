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
    
}
