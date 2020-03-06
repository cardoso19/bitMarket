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
}

public struct Bpi: Decodable {
    public let usd, gbp, eur: CriptoCurrencyRate

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

public struct CriptoCurrencyRate: Decodable {
    public let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case rateFloat = "rate_float"
    }
}
