//
//  Currency.swift
//  Network
//
//  Created by Matheus Cardoso Kuhn on 04/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import Foundation

public enum Currency: String, Decodable {
    case cad = "CAD"
    case hkd = "HKD"
    case isk = "ISK"
    case php = "PHP"
    case dkk = "DKK"
    case huf = "HUF"
    case czk = "CZK"
    case gbp = "GBP"
    case ron = "RON"
    case sek = "SEK"
    case idr = "IDR"
    case inr = "INR"
    case brl = "BRL"
    case rub = "RUB"
    case hrk = "HRK"
    case jpy = "JPY"
    case thb = "THB"
    case chf = "CHF"
    case eur = "EUR"
    case myr = "MYR"
    case bgn = "BGN"
    case `try` = "TRY"
    case cny = "CNY"
    case nok = "NOK"
    case nzd = "NZD"
    case zar = "ZAR"
    case usd = "USD"
    case mxn = "MXN"
    case sgd = "SGD"
    case aud = "AUD"
    case ils = "ILS"
    case krw = "KRW"
    case pln = "PLN"
    
    public var locale: String {
        switch self {
        case .usd:
            return "en_US"
        case .eur:
            return "de"
        case .gbp:
            return "en_GB"
        default:
            return "en_US_POSIX"
        }
    }
}
