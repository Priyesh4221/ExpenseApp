//
//  NotificationsTableViewCell.swift
//  Expenseapp
//
//  Created by admin on 11/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var outerview: UIView!
    
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var matter: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var acceptbtn: UIButton!
    
    
    @IBOutlet weak var declinebtn: UIButton!
    
    var currentnotif : notification?
    
    var notificationresponded : ((_ x: notification , _ y : Bool) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
            self.declinebtn.isHidden = false
           self.acceptbtn.isHidden = false
            self.acceptbtn.isEnabled = true
        self.declinebtn.isEnabled = true
        
    }
    
    
    func update(n : notification)
    {
        self.currentnotif = n
        self.selectionStyle = .none
        setupcolors()
        if n.title.count == 0 {
           self.title.text = " "
        }
        else {
            self.title.text = n.title.capitalized
        }
        self.matter.text = n.matter.capitalized
        self.time.text = "\(convertTimestamp(serverTimestamp : n.time))"
        
        if n.needapproval == true && n.receipientresponded == false {
            self.acceptbtn.isHidden = false
            self.declinebtn.isHidden = false
        }
        else {
            if n.needapproval && n.status == "approve" {
                self.declinebtn.isHidden = true
                self.acceptbtn.setTitle("Approved", for: .normal)
                self.acceptbtn.isEnabled = false
            }
            else if n.needapproval && n.status == "denied" {
                self.acceptbtn.isHidden = true
                self.declinebtn.setTitle("Rejected", for: .normal)
                self.declinebtn.isEnabled = false
            }
            else {
                self.acceptbtn.isHidden = true
                self.declinebtn.isHidden = true
            }
        }
    }
    
    func convertTimestamp(serverTimestamp: Int64) -> String {
        
        var gd = TimeInterval(exactly: serverTimestamp)
        
        if let xx = TimeInterval(serverTimestamp) as? TimeInterval {
            let x = xx / 1000
            
        
            let date = NSDate(timeIntervalSince1970: Double(x))
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")

            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            
            return formatter.string(from: date as Date)
        }
        return ""
    }
    
    func setupcolors()
    {
        self.outerview.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.outerview.layer.borderWidth = 1
        self.outerview.layer.cornerRadius = 5
        
        self.title.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.matter.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.time.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.acceptbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.acceptbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.declinebtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.declinebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.acceptbtn.layer.cornerRadius = self.acceptbtn.frame.size.height/2
        self.declinebtn.layer.cornerRadius = self.declinebtn.frame.size.height/2
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
    
    @IBAction func acceptbtntapped(_ sender: Any) {
        if let c = self.currentnotif {
        self.notificationresponded!(c , true)
        }
    }
    
    
    @IBAction func declinebtntapped(_ sender: Any) {
        if let c = self.currentnotif {
        self.notificationresponded!(c , false)
        }
    }
    
}




