//
//  SplitAmongCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/16/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class SplitAmongCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    
    @IBOutlet weak var selectionview: UIView!
    
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var nametopspace: NSLayoutConstraint!
    
    @IBOutlet weak var contacr: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    
    
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
    
    
    func updatecell(x : user)
    {
        self.cellview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.contacr.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.name.text = "\(x.name.capitalized)"
        if x.status.lowercased() == "phone" || x.status.lowercased() == "guest" {
            nametopspace.constant = 8
            contacr.text = x.mobile
        }
        else {
            contacr.text = ""
            nametopspace.constant = 32
        }
        
        self.selectionview.backgroundColor = UIColor.clear
        self.selectionview.layer.cornerRadius = 30
        self.selectionview.layer.shadowPath = UIBezierPath(rect: self.selectionview.bounds).cgPath
        self.selectionview.layer.shadowRadius = 25
        self.selectionview.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.selectionview.layer.shadowOpacity = 0.35
        self.selectionview.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.selectionview.clipsToBounds = true
        
        
        if x.selected {
//            self.selectionview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.cellview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
            self.name.textColor = hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
            self.userimage.tintColor = hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
            self.userimage.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getsecondaryfont()).cgColor
            self.contacr.textColor = hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
        }
        else {
//            self.selectionview.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.cellview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
            self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.userimage.tintColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
            self.userimage.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getsecondary()).cgColor
            self.contacr.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        }
        
        self.userimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               
              
                 if let myImage = UIImage(named: "user") {
                        let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                       self.userimage.image = tintableImage
                    }
        
        
    }
    
    func toggleselection(x : Bool)
    {
        if x == false
        {
           
//            self.selectionview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.cellview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
            self.userimage.tintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
            self.userimage.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
            self.contacr.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        }
        else
        {
           
//            self.selectionview.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.cellview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
             self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.userimage.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.userimage.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
            self.contacr.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        }
        
    }
    
    
}
