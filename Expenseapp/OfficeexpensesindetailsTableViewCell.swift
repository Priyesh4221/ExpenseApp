//
//  OfficeexpensesindetailsTableViewCell.swift
//  Expenseapp
//
//  Created by admin on 27/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class OfficeexpensesindetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var outerview: UIView!
    
    
    @IBOutlet weak var salesorpurchase: UILabel!
    
    
    @IBOutlet weak var amount: UILabel!
    
    
    @IBOutlet weak var enteredon: UILabel!
    
    
    
    
    
    
    
    func update(x : officeexpenserecord , y : String)
    {
        self.outerview.layer.cornerRadius = 10
        self.outerview.layer.borderWidth = 1
        self.outerview.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.salesorpurchase.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.enteredon.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        if y == "officeexpenses" {
            self.salesorpurchase.text = x.mode.capitalized
        }
        else if y == "houseexpenses" {
            self.salesorpurchase.text = x.subject.capitalized
        }
        self.amount.text = "\(x.amount)"
        self.enteredon.text = "\(convertTimestamp(serverTimestamp : x.createdon))"
    }
    
    func convertTimestamp(serverTimestamp: Int64) -> String {
        print("Sv \(serverTimestamp)")
        var gd = TimeInterval(exactly: serverTimestamp)
        print("gd \(gd)")
        if let xx = TimeInterval(serverTimestamp) as? TimeInterval {
            let x = xx / 1000
            print("XX \(x)")
        
            let date = NSDate(timeIntervalSince1970: Double(x))
            print(date)
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")

            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            
            return formatter.string(from: date as Date)
        }
        return ""
    }
    
    
    
    

}
