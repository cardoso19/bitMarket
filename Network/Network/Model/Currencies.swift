//
//  Currencies.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public struct Currencies: Decodable {
    public let rates: [Currency: Double]
}
