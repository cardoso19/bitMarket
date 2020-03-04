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
    
    public var url: String {
        return "https://api.coindesk.com/v1/bpi/historical/close.json?"
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .list:
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
        }
    }
}
