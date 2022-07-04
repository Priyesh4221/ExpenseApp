//
//  CategoryCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/27/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagecover: UIView!
    
    @IBOutlet weak var outerview: UIView!
    
    @IBOutlet weak var categoryicon: UIImageView!
    
    @IBOutlet weak var categoryname: UILabel!
    
    
    
    func update(x : String)
    {
        self.outerview.layer.cornerRadius = 10
        self.outerview.layer.borderWidth = 2
        self.outerview.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.categoryname.text = x.capitalized
        self.categoryname.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.imagecover.backgroundColor = UIColor.clear
        self.imagecover.layer.cornerRadius = 43
        self.imagecover.layer.shadowPath = UIBezierPath(rect: self.imagecover.bounds).cgPath
        self.imagecover.layer.shadowRadius = 25
        self.imagecover.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.imagecover.layer.shadowOpacity = 0.35
        self.imagecover.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.imagecover.clipsToBounds = true
        
        self.categoryicon.clipsToBounds = true
        
        
        
        
        let insets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        self.categoryicon.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               
               if x == "individuals" {
                 if let myImage = UIImage(named: "user") {
                        let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                       self.categoryicon.image = tintableImage
                    }
               }
               else if x == "bills" {
                   if let myImage = UIImage(named: "bill") {
                                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                                  self.categoryicon.image = tintableImage
                               }
               }
               else if x == "office expenses" {
                   if let myImage = UIImage(named: "office") {
                                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                                  self.categoryicon.image = tintableImage
                               }
               }
               else if x == "house expenses" {
                   if let myImage = UIImage(named: "house") {
                                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                                  self.categoryicon.image = tintableImage
                               }
               }
    }
    
    
    
}
