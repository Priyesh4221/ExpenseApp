//
//  PreviousRecordTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/23/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class PreviousRecordTableViewCell: UITableViewCell {

   
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func updatecell(x:String , y:String , z:String ,  w : String)
    {
        self.selectionStyle = .none
//        if w == "paid" {
//            self.amount.textColor = UIColor.green
//
//        }
//        else {
//            self.amount.textColor = UIColor.red
//
//        }
        self.amount.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.title.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.date.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.amount.text = "Rs. \(x)"
        self.date.text = y
        self.title.text = z.capitalized
    }
}
