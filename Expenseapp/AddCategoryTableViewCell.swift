//
//  AddCategoryTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/24/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class AddCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var coverview: UIView!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updatecell(x:String , y:String)
    {
        self.titlelabel.textColor = hexStringToUIColor(hex: Theme.theme.gettertiaryfont())
        self.subtitle.textColor = hexStringToUIColor(hex: Theme.theme.gettertiaryfont())
        self.coverview.backgroundColor = hexStringToUIColor(hex: Theme.theme.gettertiary())
        self.titlelabel.text = x.capitalized
        self.subtitle.text = y.capitalized
    }
}
