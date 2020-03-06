//
//  CriptoCurrencyRequest.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public enum CriptoCurrencyRequest: RequestSetup {
    case list(String, String)
    case current
    
    private var baseUrl: String {
        return "https://api.coindesk.com/v1/bpi"
    }
    
    public var url: String {
        switch self {
        case .list:
            return "\(baseUrl)/historical/close.json?"
        case .current:
            return "\(baseUrl)/currentprice.json"
        }
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .list, .current:
            return .get
        }
    }
    
    public var parameters: [String : Encodable]? {
        switch self {
        case let .list(start, end):
            return [
                "start": start,
                "end": end
            ]
        case .current:
            return nil
        }
    }
}
