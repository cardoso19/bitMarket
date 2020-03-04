//
//  HttpRequest.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public protocol Requesting {
    func request<T: Decodable>(with setup: RequestSetup, completion: @escaping (Result<T, RequestError>) -> Void)
}

public final class HttpRequest: Requesting {

    // MARK: - Variables
    private let session: URLSession

    // MARK: - Life Cycle
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - Data Request
    public func request<T: Decodable>(with setup: RequestSetup, completion: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: setup.url) else {
            completion(.failure(.urlNotFound))
            return
        }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: setup.cachePolicy,
                                    timeoutInterval: setup.timeoutInterval)
        urlRequest.httpMethod = setup.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = setup.httpHeaders
        do {
            try handle(request: &urlRequest, setup: setup)
        } catch {
            guard let error = error as? RequestError else { return }
            completion(.failure(error))
            return
        }
        session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            guard let data = data
                else {
                    completion(.failure(.brokenData))
                    return
            }
            guard let httpResponse = response as? HTTPURLResponse
                else {
                    completion(.failure(.invalidHttpResponse))
                    return
            }
            completion(self.handleHTTPStatus(response: httpResponse, data: data))
        }.resume()
    }

    private func handle(request: inout URLRequest, setup: RequestSetup) throws {
        if let parameters = setup.parameters, !parameters.isEmpty {
            switch setup.httpMethod {
            case .get:
                guard var urlComponent = URLComponents(string: setup.url)
                    else {
                        throw RequestError.urlNotFound
                }
                urlComponent.queryItems = []
                for parameter in parameters {
                    urlComponent.queryItems?.append(URLQueryItem(name: parameter.key,
                                                                 value: parameter.value as? String))
                }
                request.url = urlComponent.url
            default:
                if let body = setup.parameters {
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: body)
                    } catch {
                        throw RequestError.couldNotEncodeObject
                    }
                }
            }
        }
    }

    private func handleHTTPStatus<T: Decodable>(response: HTTPURLResponse, data: Data) -> Result<T, RequestError> {
        switch response.statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .coindesk
                let responseModel = try decoder.decode(T.self, from: data)
                return .success(responseModel)
            } catch {
                return .failure(.couldNotParseObject)
            }
        case 400:
            return .failure(.badRequest)
        case 403:
            return .failure(.forbidden)
        case 404:
            return .failure(.couldNotFindHost)
        case 500:
            return .failure(.internalServerError)
        default:
            return .failure(.unknown("Unexpected error."))
        }
    }
}
