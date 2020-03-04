//
//  CriptoCurrencyHistorical.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public struct CriptoCurrencyHistorical: Decodable {
    public let bpi: [Date: Double]
}
