//
//  SpliAmongCollectionCollectionReusableView.swift
//  Expenseapp
//
//  Created by admin on 21/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class SpliAmongCollectionCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var head: UILabel!
    
    override func awakeFromNib() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100)
        head.textAlignment = .left
    }
    
        
}
