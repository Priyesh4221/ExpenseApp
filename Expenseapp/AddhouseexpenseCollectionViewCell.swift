//
//  AddhouseexpenseCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 5/3/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class AddhouseexpenseCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var outerview: UIView!
    
    @IBOutlet weak var catimage: UIImageView!
    
    
    @IBOutlet weak var catname: UILabel!
    
    func update(x : String)
    {
        self.outerview.backgroundColor = UIColor.clear
        self.outerview.layer.cornerRadius = 40
        self.outerview.layer.shadowPath = UIBezierPath(rect: self.outerview.bounds).cgPath
        self.outerview.layer.shadowRadius = 25
        self.outerview.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.outerview.layer.shadowOpacity = 0.35
        self.outerview.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.outerview.clipsToBounds = true
        
        self.catimage.clipsToBounds = true
        
        
        self.catimage.layer.cornerRadius = self.catimage.frame.size.height/2
        self.catimage.layer.borderWidth = 1
        self.catimage.layer.borderColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.catname.textColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.catname.text = x.capitalized
        
    }
    
    
}
