//
//  RoundedImageExceptional.swift
//  Expenseapp
//
//  Created by PRIYESH  on 4/1/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit
@IBDesignable
class RoundedImageExceptional: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
    
    @IBInspectable var cornradius : CGFloat = 0
        {
        didSet
        {
            self.layer.cornerRadius = cornradius
            self.layer.masksToBounds = cornradius > 0
        }
        
    }
    
    @IBInspectable var borderwidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderwidth
        }
    }
    @IBInspectable var bordercolor : UIColor? {
        didSet {
            self.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        }
    }
    @IBInspectable var bgcolor : UIColor? {
        didSet {
            self.layer.backgroundColor = bgcolor?.cgColor
        }
    }
    override func awakeFromNib() {
        
        
    }

}
