//
//  BillsplitresultCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 4/13/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class BillsplitresultCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var coverview: UIView!
    
    
    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var useramount: UILabel!
    
    @IBOutlet weak var paidinadvcne: UILabel!
    
    @IBOutlet weak var netamount: UILabel!
    
    func update(x : user , y : Int , a : Int , b : Int)
    {
        self.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.layer.cornerRadius = 10
        
        
        self.username.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useramount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.paidinadvcne.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.netamount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        print("I am being called")
        self.username.text = x.name.capitalized
        self.useramount.text = "Bill amount : \(y)"
        self.paidinadvcne.text = "Already Paid : \(a)"
        if b > 0 {
        self.netamount.text = "Amount Due : \(b)"
            self.netamount.textColor = UIColor.red
        }
        else {
            self.netamount.text = "Amount you receive : \(b * -1)"
             self.netamount.textColor = UIColor.green
        }
        self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2
        self.userimage.layer.borderWidth = 1
        self.userimage.layer.borderColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
       
        
        self.coverview.backgroundColor = UIColor.clear
        self.coverview.layer.cornerRadius = 45
        self.coverview.layer.shadowPath = UIBezierPath(rect: self.coverview.bounds).cgPath
        self.coverview.layer.shadowRadius = 25
        self.coverview.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.coverview.layer.shadowOpacity = 0.35
        self.coverview.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.coverview.clipsToBounds = true
        
        self.userimage.clipsToBounds = true
        var col = CIColor(color: hexStringToUIColor(hex: Theme.theme.getprimary()))
               var rc = col.red * 0.7
               var bc = col.blue * 0.7
               var gc = col.green * 0.7
               
               var newcol = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1060038527)
               
        self.contentView.backgroundColor = newcol
        
    }
    
    
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
    
    
}
