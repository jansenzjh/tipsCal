//
//  Extension.swift
//  TipsCal
//
//  Created by Jansen on 1/7/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func roundUpTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.up) / divisor
    }
    
    
    func roundDownTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.down) / divisor
    }
    
    func roundStandardTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension DefaultsKeys {
    static let dfTaxRate = DefaultsKey<Double>("taxRate")
    static let dfIsTipOnTax = DefaultsKey<Bool>("isTipOnTax")
    static let dfRoundingType = DefaultsKey<Int>("roundingType")
    static let dfNearestRoundingType = DefaultsKey<String>("nearestRoundingType")
    
    
}
