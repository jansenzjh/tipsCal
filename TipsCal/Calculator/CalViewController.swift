//
//  CalViewController.swift
//  TipsCal
//
//  Created by Jansen on 1/5/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import Eureka
import FontAwesome

class CalViewController: FormViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadForm()
        UIInit()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func Calculate() {
        
        let valuesDictionary = form.values()
        print(valuesDictionary)
    }
    
    func UIInit() {
        
    
        if let tabBarItems = self.tabBarController?.tabBar.items {
            for item in tabBarItems {
                if item.title == "Calculator" {
                    item.image = UIImage.fontAwesomeIcon(name: .calculator, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }else if item.title == "Setting" {
                    item.image = UIImage.fontAwesomeIcon(name: .gears, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }
            }
        }
    }
    
    func LoadForm() {
        form = Section("Subtotal")
            <<< DecimalRow("subtotalRowTag"){ row in
                row.title = "Subtotal"
                row.placeholder = "Subtotal here"
            }
            <<< SwitchRow("isSubtotalIncludeTaxAlreadyRowTag"){ row in
                row.title = "Subtotal includes Tax"
            }
            
            +++ Section("Tip Rate")
            <<< SegmentedRow<String>("tipRateRowTag"){
                $0.options = ["10%", "12%", "15%", "18%", "20%"]
                
                }.onChange { row in
                    print(row.value ?? "No Value")
                    self.Calculate()
            }
            <<< DecimalRow("customTipRate"){ row in
                row.title = "Custom Tip Rate"
                row.placeholder = "Enter here"
            }
            
            +++ Section("Split")
            <<< SwitchRow("billSplitRowTag"){
                $0.title = "Bill Split"
            }
            <<< SegmentedRow<Int>("billSplitSegmentRowTag"){
                $0.options = [2, 3, 4, 5, 6]
                $0.hidden = Condition.function(["billSplitRowTag"], { form in
                    return !((form.rowBy(tag: "billSplitRowTag") as? SwitchRow)?.value ?? false)
                })
                
            }
            <<< IntRow("customSplitRowTag"){
                $0.hidden = Condition.function(["billSplitRowTag"], { form in
                    return !((form.rowBy(tag: "billSplitRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Other Number"
                $0.placeholder = "Enter here"
            }
            
            +++ Section("Result")
            <<< DecimalRow("tipPerPersonRowTag"){
                $0.title = "Tips/person"
                $0.hidden = Condition.function(["billSplitRowTag"], { form in
                    return !((form.rowBy(tag: "billSplitRowTag") as? SwitchRow)?.value ?? false)
                })
            }
            <<< DecimalRow("tipsTotalRowTag"){
                $0.title = "Tips Total"
            }
            <<< DecimalRow("taxPerPersonRowTag"){
                $0.title = "Tax/person"
                $0.hidden = Condition.function(["billSplitRowTag"], { form in
                    return !((form.rowBy(tag: "billSplitRowTag") as? SwitchRow)?.value ?? false)
                })
            }
            <<< DecimalRow("taxTotalRowTag"){
                $0.title = "Tax Total"
            }
            <<< DecimalRow("totalPerPersonRowTag"){
                $0.title = "Total/person"
                $0.hidden = Condition.function(["billSplitRowTag"], { form in
                    return !((form.rowBy(tag: "billSplitRowTag") as? SwitchRow)?.value ?? false)
                })
            }
            <<< DecimalRow("totalRowTag"){
                $0.title = "Total"
        }

    }
}
