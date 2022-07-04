//
//  SubjectsCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/3/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class SubjectsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var subjectno: UILabel!
    
    @IBOutlet weak var subjectname: CustomTextField!
    
    @IBOutlet weak var feesmonthlyordaily: CustomTextField!
    
    
    @IBOutlet weak var noofclassesinmonth: CustomTextField!
    
    @IBOutlet weak var labelsubjectname: UILabel!
    
    @IBOutlet weak var labelmonthlyfees: UILabel!
    
    @IBOutlet weak var labelclasses: UILabel!
    
    
    
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
    func updatecell(x:Int)
    {
        self.subjectno.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.subjectname.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.feesmonthlyordaily.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
          self.noofclassesinmonth.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.labelsubjectname.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.labelmonthlyfees.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.labelclasses.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.subjectname.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
          self.feesmonthlyordaily.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
          self.noofclassesinmonth.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
    self.subjectno.text = "Subject \(x)"
    }
    
    
   
    func displaycell()
    {
        print("Subject no \(self.subjectno.text) with subject name \(self.subjectname.text) feesmonthly \(self.feesmonthlyordaily.text) and noofclasses \(self.noofclassesinmonth.text)")
    }
    
}
