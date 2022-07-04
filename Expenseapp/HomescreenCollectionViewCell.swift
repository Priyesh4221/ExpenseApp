//
//  HomescreenCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/26/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class HomescreenCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var recentimage: UIImageView!
    
    @IBOutlet weak var recentusername: UILabel!
    
    
    @IBOutlet weak var imagecover: UIView!
    
    
    func update(x : recentcontacts)
    {
        
        
        self.imagecover.backgroundColor = UIColor.clear
        self.imagecover.layer.cornerRadius = 40
        self.imagecover.layer.shadowPath = UIBezierPath(rect: self.imagecover.bounds).cgPath
        self.imagecover.layer.shadowRadius = 25
        self.imagecover.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.imagecover.layer.shadowOpacity = 0.35
        self.imagecover.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.recentusername.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.imagecover.clipsToBounds = true
        
        self.recentimage.clipsToBounds = true
        
        self.recentimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        if x.type == "individual" {
          if let myImage = UIImage(named: "user") {
                 let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                self.recentimage.image = tintableImage
             }
        }
        else if x.type == "billsplit" {
            if let myImage = UIImage(named: "bill") {
                            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                           self.recentimage.image = tintableImage
                        }
        }
        else if x.type == "office expenses" {
            if let myImage = UIImage(named: "office") {
                            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                           self.recentimage.image = tintableImage
                        }
        }
        else if x.type == "house expenses" {
            if let myImage = UIImage(named: "house") {
                            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                           self.recentimage.image = tintableImage
                        }
        }
        
        
        
        self.recentusername.text = x.name.capitalized
        
        let insets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    
}
