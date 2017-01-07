//
//  SetttingViewController.swift
//  TipsCal
//
//  Created by Jansen on 1/6/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import Eureka
import SwiftyUserDefaults

class SettingViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        LoadForm()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Save setting
        
        //tax rate data
        let taxRateRow: DecimalRow? = form.rowBy(tag: "taxRateRowTag")
        let taxRateRowValue = taxRateRow?.value
        if taxRateRowValue == nil{
           Defaults[.dfTaxRate] = 0
        }else{
            Defaults[.dfTaxRate] = taxRateRowValue!
        }
        
        
        //include tip data
        let includeTipRow: SwitchRow? = form.rowBy(tag: "IsTipOnTax")
        let includeTipRowValue = includeTipRow?.value
        Defaults[.dfIsTipOnTax] = includeTipRowValue!
        
        //Rounding data
        let roundingAreaTypeRow: SegmentedRow<String>? = form.rowBy(tag: "billSplitAreaSegmentRowTag")
        let billSplitArea = roundingAreaTypeRow?.value
        
        let roundingMethodTypeRow: SegmentedRow<String>? = form.rowBy(tag: "billSplitMethodSegmentRowTag")
        let billSplitMethod = roundingMethodTypeRow?.value
        
        if billSplitArea == "None"{
            Defaults[.dfRoundingType] = RoundingTypes.None.rawValue
        }
        if billSplitArea == "Tip"{
            if billSplitMethod == "Standard" {
                Defaults[.dfRoundingType] = RoundingTypes.TipStandard.rawValue
            }else if billSplitMethod == "Up" {
                Defaults[.dfRoundingType] = RoundingTypes.TipUp.rawValue
            }else if billSplitMethod == "Down" {
                Defaults[.dfRoundingType] = RoundingTypes.TipDown.rawValue
            }
        }else if billSplitArea == "Total"{
            if billSplitMethod == "Standard" {
                Defaults[.dfRoundingType] = RoundingTypes.TotalStandard.rawValue
            }else if billSplitMethod == "Up" {
                Defaults[.dfRoundingType] = RoundingTypes.TotalUp.rawValue
            }else if billSplitMethod == "Down" {
                Defaults[.dfRoundingType] = RoundingTypes.TotalDown.rawValue
            }
        }
        
        //Rounding Nearest data
        let nearestRow: SegmentedRow<String>? = form.rowBy(tag: "billSplitNearestSegmentRowTag")
        let nearestRowValue = nearestRow?.value
        if nearestRowValue == "Nearest Dollar #.00" {
            Defaults[.dfNearestRoundingType] = NearestRoundingTypes.NearestDollar.rawValue
        }else{
            Defaults[.dfNearestRoundingType] = NearestRoundingTypes.NearestTenth.rawValue
        }
        
        
    }
    
    func LoadForm(){
        let rndType = Defaults[.dfRoundingType]
        
        form = Section("Tax Rate")
            <<< DecimalRow("taxRateRowTag"){ row in
                row.title = "Rate"
                row.placeholder = "In Persentage"
                if Defaults[.dfTaxRate] > 0 {
                    row.value = Defaults[.dfTaxRate]
                }
                
            }
            <<< SwitchRow("IsTipOnTax"){row in
                row.title = "Tip on Tax?"
                row.value = Defaults[.dfIsTipOnTax]
                
            }
            +++ Section("Rounding")
            <<< SegmentedRow<String>("billSplitAreaSegmentRowTag"){
                $0.options = ["None", "Tip", "Total"]
                if rndType == RoundingTypes.TipDown.rawValue || rndType == RoundingTypes.TipUp.rawValue || rndType == RoundingTypes.TipStandard.rawValue{
                    $0.value = "Tip"
                }else if rndType == RoundingTypes.TotalDown.rawValue || rndType == RoundingTypes.TotalUp.rawValue || rndType == RoundingTypes.TotalStandard.rawValue{
                    $0.value = "Total"
                }else{
                    $0.value = "None"
                }
                
            }
            <<< SegmentedRow<String>("billSplitMethodSegmentRowTag"){
                $0.options = ["Standard", "Up", "Down"]
                if rndType == RoundingTypes.TotalUp.rawValue || rndType == RoundingTypes.TipUp.rawValue {
                    $0.value = "Up"
                }else if rndType == RoundingTypes.TotalDown.rawValue || rndType == RoundingTypes.TipDown.rawValue {
                    $0.value = "Down"
                }else{
                    $0.value = "Standard"
                }
            }
            <<< SegmentedRow<String>("billSplitNearestSegmentRowTag"){
                $0.options = ["Nearest Dollar #.00", "Nearest Tenth #.#0"]
                $0.value = Defaults[.dfNearestRoundingType]
        }
    }
    
    func UIInit() {
        //tabBarItem.image = UIImage.fontAwesomeIcon(name: .gears, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
    }


}
