//
//  ChooseRankCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/26/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class ChooseRankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           self.endEditing(true)
           return true
       }
    
    func updatecell(x:String)
    {
        self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.name.text = x
    }
}
