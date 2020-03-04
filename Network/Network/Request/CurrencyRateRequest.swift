//
//  CurrencyRateRequest.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public enum CurrencyRateRequest: RequestSetup {
    case rate(Currency)
    
    public var url: String {
        switch self {
        case .rate:
            return "https://api.exchangeratesapi.io/latest?"
        }
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .rate:
            return .get
        }
    }
    
    public var parameters: [String : Encodable]? {
        switch self {
        case let .rate(base):
            return ["base": base.rawValue]
        }
    }
}
