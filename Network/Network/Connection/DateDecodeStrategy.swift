//
//  DateDecodeStrategy.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let coindesk = custom { decoder throws -> Date in
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
