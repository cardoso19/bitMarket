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
    case value(String)
    
    public var url: String {
        switch self {
        case let .list(start, end):
            return "\(start),\(end)"
        case let .value(date):
            return "\(date)"
        }
    }
    
    public var httpMethod: HttpMethod { return .get }
    public var parameters: [String : Encodable]? { return nil }
}
