//
//  CalculationBrain.swift
//  TipsCal
//
//  Created by Jansen on 1/6/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import Foundation

class CalculationBrain {
    var Subtotal: Double = 0
    var TipRate: Double = 0
    var IsTaxInTip: Bool = false
    var IsSubtotalIncludeTax: Bool = true
    var RoundingType: RoundingTypes = RoundingTypes.None
    var TaxRate: Double = 0
    var SplitCount = 1
    var Total: Double = 0
    var NearestRoundingType: NearestRoundingTypes = NearestRoundingTypes.NearestDollar
    
    init() {
    }
    
    init(st: Double, tipRate: Double, isTaxInTip: Bool, isSubtotalIncludeTax: Bool, roundingType: RoundingTypes, taxRate: Double, split: Int, nearestRounding: NearestRoundingTypes) {
        Subtotal = st
        TipRate = tipRate
        IsTaxInTip = isTaxInTip
        IsSubtotalIncludeTax = isSubtotalIncludeTax
        RoundingType = roundingType
        TaxRate = taxRate
        SplitCount = split
        NearestRoundingType = nearestRounding
    }
    
    func GetTipWithTax() -> Double {
        if IsSubtotalIncludeTax {
            return Subtotal * TipRate / 100
        }else{
            return Subtotal * (1 + TaxRate / 100) * TipRate / 100
        }
    }
    
    func GetTipWithoutTax() -> Double {
        if IsSubtotalIncludeTax {
            return (Subtotal / (1 + TaxRate/100) * TipRate / 100)
        }else{
            return Subtotal * TipRate / 100
        }
    }
    
    func GetTotalWithTaxAndTip() -> Double {
        return Subtotal + GetTipWithTax()
    }
    
    func GetTotalWithoutTaxButWithTip() -> Double {
        return Subtotal + GetTipWithoutTax()
    }
    
    func GetTipWithTaxSplit() -> Double {
        return GetTipWithoutTax() / Double(SplitCount)
    }
    
    func GetTipWithoutTaxSplit() -> Double {
        return GetTipWithoutTax() / Double(SplitCount)
    }
    
    func GetTotalWithTaxAndTipSplit() -> Double {
        return GetTotalWithTaxAndTip() / Double(SplitCount)
    }
    
    func GetTotalWithoutTaxButWithTipSplit() -> Double {
        return GetTotalWithoutTaxButWithTip() / Double(SplitCount)
    }
    
    func Rounding(num: Double) -> Double {
        var roundingDecimal = 2
        if NearestRoundingType == NearestRoundingTypes.NearestDollar{
            roundingDecimal = 0
        }else if NearestRoundingType == NearestRoundingTypes.NearestTenth{
            roundingDecimal = 1
        }
        switch RoundingType {
        case RoundingTypes.None:
            return num.roundTo(places: roundingDecimal)
        case RoundingTypes.TipDown:
            return num.roundDownTo(places: roundingDecimal)
        case RoundingTypes.TipUp:
            return num.roundUpTo(places: roundingDecimal)
        case RoundingTypes.TipStandard:
            return num.roundStandardTo(places: roundingDecimal)
        case RoundingTypes.TotalDown:
            return num.roundDownTo(places: roundingDecimal)
        case RoundingTypes.TotalUp:
            return num.roundUpTo(places: roundingDecimal)
        case RoundingTypes.TotalStandard:
            return num.roundStandardTo(places: roundingDecimal)
        }
    }
    
}
