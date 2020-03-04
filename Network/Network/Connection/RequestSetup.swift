//
//  RequestSetup.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public protocol RequestSetup {
    var url: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
    var httpMethod: HttpMethod { get }
    var httpHeaders: [String: String]? { get }
    var parameters: [String: Encodable]? { get }
}

extension RequestSetup {
    public var cachePolicy: URLRequest.CachePolicy { return .reloadIgnoringLocalAndRemoteCacheData }
    public var timeoutInterval: TimeInterval { return 3 }
    public var httpHeaders: [String: String]? { return nil }
}
