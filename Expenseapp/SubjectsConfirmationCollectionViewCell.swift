//
//  SubjectsConfirmationCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/15/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class SubjectsConfirmationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var paid: UILabel!
    
    @IBOutlet weak var fees: UILabel!
    
    @IBOutlet weak var classes: UILabel!
    
    @IBOutlet weak var underline: UIView!
    
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
    
    func updatecell(x : subjectdetail)
    {
          self.subject.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.paid.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.fees.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.classes.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.underline.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.subject.text = "Subject  \(x.subjectname)"
        self.paid.text = "Fees Payment Mode : \(x.feesmode)"
        self.fees.text = "Fees per month : Rs \(x.feesamount)"
        self.classes.text = "No of classes in a month : \(x.noofclasses)"
    }
    
    
}
