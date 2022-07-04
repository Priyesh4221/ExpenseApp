//
//  ContactTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/22/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    
    
    
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.amountdue.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.type.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.upperhalf.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        let shapelayer = CAShapeLayer()
        let radius = self.frame.size.width/24
        let c = self.center.x
        let d = self.center.y*0.8 - radius
        let cen = CGPoint(x: ((self.upperhalf.frame.size.width) * 0.95), y: 0)
        
       
         let circularpath = UIBezierPath(arcCenter: cen, radius: radius, startAngle:  0, endAngle:CGFloat.pi, clockwise: true)
        shapelayer.path = circularpath.cgPath
        shapelayer.fillColor = hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        
        shapelayer.strokeEnd = 0
        shapelayer.lineCap = kCALineCapRound
        shapelayer.strokeColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        shapelayer.lineWidth = 6
        shapelayer.opacity = 0.95
        
        self.upperhalf.layer.addSublayer(shapelayer)
        
        
        
    }

    @IBOutlet weak var amountdue: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: RoundedImage!
    
    
    @IBOutlet weak var profileimagewrapper: UIView!
    
    @IBOutlet weak var upperhalf: UIView!
    
    
    func updatecell(x : String , y : String , z : String)
    {
        
        self.profileimagewrapper.backgroundColor = UIColor.clear
        self.profileimagewrapper.layer.cornerRadius = 43
        self.profileimagewrapper.layer.shadowPath = UIBezierPath(rect: self.profileimagewrapper.bounds).cgPath
        self.profileimagewrapper.layer.shadowRadius = 25
        self.profileimagewrapper.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.profileimagewrapper.layer.shadowOpacity = 0.35
        self.profileimagewrapper.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        self.upperhalf.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.profileimagewrapper.clipsToBounds = true
        
        
        
        self.name.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.type.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amountdue.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.name.text = x.capitalized
        self.type.text = y.capitalized
        self.amountdue.text = "Amount Due : \(z)"
        
        self.photo.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        
        
          if let myImage = UIImage(named: "user") {
                 let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                self.photo.image = tintableImage
             }
    }

}
