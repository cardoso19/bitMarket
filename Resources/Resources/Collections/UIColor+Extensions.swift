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
        return UIColor(named: "primary", in: bundle, compatibleWith: .current)
    }
    static var secondary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "secondary", in: bundle, compatibleWith: .current)
    }
    static var tertiary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "tertiary", in: bundle, compatibleWith: .current)
    }
    static var quaternary: UIColor? {
        guard let bundle = bundle else { return nil }
        return UIColor(named: "quaternary", in: bundle, compatibleWith: .current)
    }
}
