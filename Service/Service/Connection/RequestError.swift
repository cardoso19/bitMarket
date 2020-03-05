//
//  RequestError.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case badRequest
    case brokenData
    case couldNotEncodeObject
    case couldNotFindHost
    case couldNotParseObject
    case forbidden
    case internalServerError
    case invalidHttpResponse
    case urlNotFound
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .badRequest: return "It's a bad request."
        case .brokenData: return "The received data is broken."
        case .couldNotEncodeObject: return "Can't convert the object to data."
        case .couldNotFindHost: return "The host was not found."
        case .couldNotParseObject: return "Can't convert the data to the object entity."
        case .forbidden: return "Authentication is required."
        case .internalServerError: return "Internal Server Error"
        case .invalidHttpResponse: return "HTTPURLResponse is nil."
        case .urlNotFound: return "Could not found URL."
        case let .unknown(message): return message
        }
    }
}

// MARK: - Equatable
extension RequestError: Equatable {
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
