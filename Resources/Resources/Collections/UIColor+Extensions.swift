//
//  UIColor+Extensions.swift
//  Resources
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit

public extension UIColor {
    
    private static var bundle: Bundle? { return Bundle(identifier: "MDT.Resources") }
    
    static var primary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "Primary", in: bundle, compatibleWith: .current)
    }
    static var secondary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "Secondary", in: bundle, compatibleWith: .current)
    }
    static var tertiary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "Tertiary", in: bundle, compatibleWith: .current)
    }
    static var quaternary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "Quaternary", in: bundle, compatibleWith: .current)
    }
}
