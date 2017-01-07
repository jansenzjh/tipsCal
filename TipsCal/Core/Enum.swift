//
//  Enum.swift
//  TipsCal
//
//  Created by Jansen on 1/6/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import Foundation

enum RoundingTypes: Int{
    case None = 0
    case TipStandard = 1
    case TipUp = 2
    case TipDown = 3
    case TotalStandard = 4
    case TotalUp = 5
    case TotalDown = 6
}

enum NearestRoundingTypes: String{
    case NearestDollar = "Nearest Dollar #.00"
    case NearestTenth = "Nearest Tenth #.#0"
}
