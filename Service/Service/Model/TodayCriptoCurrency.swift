//
//  TodayCriptoCurrency.swift
//  Service
//
//  Created by Matheus Cardoso Kuhn on 06/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public struct TodayCriptoCurrency: Decodable {
    public let bpi: Bpi
    
    public init(bpi: Bpi) {
        self.bpi = bpi
    }
}

public struct Bpi: Decodable {
    public let usd, gbp, eur: CriptoCurrencyRate

    public init(usd: CriptoCurrencyRate, gbp: CriptoCurrencyRate, eur: CriptoCurrencyRate) {
        self.usd = usd
        self.gbp = gbp
        self.eur = eur
    }
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

public struct CriptoCurrencyRate: Decodable {
    public let rateFloat: Double

    public init(rateFloat: Double) {
        self.rateFloat = rateFloat
    }
    
    enum CodingKeys: String, CodingKey {
        case rateFloat = "rate_float"
    }
}
