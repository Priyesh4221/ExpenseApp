//
//  ShowIndividualBillCollectionViewCell.swift
//  Expenseapp
//
//  Created by admin on 19/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class ShowIndividualBillCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sv1: UIStackView!
    
    @IBOutlet weak var sv2: UIStackView!
    
    @IBOutlet weak var sv3: UIStackView!
    
    @IBOutlet weak var netamountupper: UILabel!
    
    
    @IBOutlet weak var amountpaidupper: UILabel!
    
    @IBOutlet weak var amountsplitupper: UILabel!
    
    @IBOutlet weak var coverview: UIView!
    
    
    @IBOutlet weak var verificationstatus: UILabel!
    
    
    @IBOutlet weak var profileimagewrapper: UIView!
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var netpay: UILabel!
    
    @IBOutlet weak var paidinadvance: UILabel!
    
    
    @IBOutlet weak var amountmeanttopay: UILabel!
    
    @IBOutlet weak var splitratio: UILabel!
    
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
    
    func setupcolors()
    {
        self.verificationstatus.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.username.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        self.netpay.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        self.paidinadvance.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        self.splitratio.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        self.amountmeanttopay.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.netamountupper.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

           self.amountpaidupper.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

           self.amountsplitupper.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.sv1.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.sv1.layer.borderWidth = 2
        self.sv1.layer.cornerRadius = 10
        
        self.sv2.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.sv2.layer.borderWidth = 2
        self.sv2.layer.cornerRadius = 10
        
        self.sv3.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.sv3.layer.borderWidth = 2
        self.sv3.layer.cornerRadius = 10

        self.coverview.layer.cornerRadius = 10
        self.coverview.alpha = 1
        self.profileimagewrapper.backgroundColor = UIColor.clear
        self.profileimagewrapper.layer.cornerRadius = 50
        self.profileimagewrapper.layer.shadowPath = UIBezierPath(rect: self.profileimagewrapper.bounds).cgPath
        self.profileimagewrapper.layer.shadowRadius = 25
        self.profileimagewrapper.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.profileimagewrapper.layer.shadowOpacity = 0.35
        self.profileimagewrapper.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.profileimagewrapper.clipsToBounds = true
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        
        
        var col = CIColor(color: hexStringToUIColor(hex: Theme.theme.getprimary()))
        var rc = col.red * 0.7
        var bc = col.blue * 0.7
        var gc = col.green * 0.7
        
        var newcol = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1060038527)
        
        self.coverview.backgroundColor = newcol
        

    }
    
    
    func update(x : billshowreceipients)
    {
        print("Updating cell")
        print(x)
        setupcolors()
        
        self.username.text = x.username.capitalized
        self.verificationstatus.text = x.verified.capitalized
        if let d = x.paymentleft as? [Int64]  {
            if d[0] > 0 {
                self.netamountupper.text = "Amount Payable by \(x.username.capitalized)"
                self.netpay.text = "Rs \(d[0])"
            }
            else {
                self.netamountupper.text = "Amount \(x.username.capitalized) will receive"
                self.netpay.text = "Rs \(d[0] * -1)"
            }
            
        }
        else {
            
        }
        self.paidinadvance.text = "Rs \(x.paidadvance[0])"
        self.splitratio.text = "Split Ratio : \(x.splitratio)"
        self.amountmeanttopay.text = "Rs \(x.amountafterspliting[0])"
        
        self.profileimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                 
                                
                                   if let myImage = UIImage(named: "user") {
                                          let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                                         self.profileimage.image = tintableImage
                                      }
        
        
    }
    
    
    
    
    
    
    
}
