//
//  CriptoCurrencyHistorical.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation
import Formatter

public struct CriptoCurrencyHistorical: Decodable {
    public let bpi: [Date: Double]
    
    public init(bpi: [Date: Double]) {
        self.bpi = bpi
    }
    
    enum CodingKeys: String, CodingKey {
        case bpi
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let bpi = try values.decode([String: Double].self, forKey: .bpi)
        var convertedBpi: [Date: Double] = [:]
        for (key, value) in bpi {
            guard let date = key.toDate(format: "yyyy-MM-dd") else { break }
            convertedBpi[date] = value
        }
        self.bpi = convertedBpi
    }
}
