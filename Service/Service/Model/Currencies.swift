//
//  Currencies.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public struct Currencies: Decodable {
    public let rates: [Currency: Double]
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rates = try values.decode([String: Double].self, forKey: .rates)
        var convertedRates: [Currency: Double] = [:]
        for (key, value) in rates {
            guard let currency = Currency(rawValue: key) else {
                break
            }
            convertedRates[currency] = value
        }
        self.rates = convertedRates
    }
}
