//
//  PromotionCollectionViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/26/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var promoimage: UIImageView!
    
    
    @IBOutlet weak var promotext: UILabel!
    
    func update()
    {
        self.promotext.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.promoimage.layer.cornerRadius = 5
        self.promoimage.layer.borderWidth = 3
        self.promoimage.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.promoimage.clipsToBounds = true
//        self.promoimage.image = UIImage(named: "p1")?.imageWithInsets(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        self.promotext.text = "Create an individual expense"
        print("Could Reach here")
    }
    
    
    
}
