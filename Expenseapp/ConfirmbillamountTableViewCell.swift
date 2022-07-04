//
//  ConfirmbillamountTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 4/18/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class ConfirmbillamountTableViewCell: UITableViewCell , UITextFieldDelegate {

  
    @IBOutlet weak var imageouter: UIView!
    
    
    @IBOutlet weak var userimage: UIImageView!
    
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var useramount: UITextField!
    
    @IBOutlet weak var userratiopart: UITextField!
    
    @IBOutlet weak var userallpaidconfirm: UIButton!
    
    @IBOutlet weak var amountheader: UILabel!
    
    @IBOutlet weak var userallpaidlabel: UILabel!
    
    @IBOutlet weak var ratioupper: UILabel!
    
    var passbackamount : ((_ x : String,_ id : String) -> Void)?
    var paidwholestatus : ((_ x : Bool,_ id : String) -> Void)?
    var takeratiopart : ((_ x : Int , _ id : String) -> Void)?
    
    var currentuser : user?
    
    var billtotalamount = 0
    var currentdict : Dictionary<String,Int> = [:]
    
    func update(x : user , y : billsplittransaction , c : Dictionary<String,Int> , state : String, ratiopart : Int)
    {
        self.selectionStyle = .none
        self.currentdict = c
        uideisgn()
        billtotalamount = Int(y.amount ?? 0)
        self.username.text = x.name.capitalized
        self.useramount.delegate = self
        self.userratiopart.delegate = self
        self.currentuser = x
        
        if let d = c["\(x.id)"] as? Int {
            self.useramount.text = "\(d)"
        }
        else {
            self.useramount.text = "0"
        }
        
        if x.billamountpaidinadvance == Int(y.amount ?? 0) {
            userallpaidconfirm.backgroundColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        }
        else {
            userallpaidconfirm.backgroundColor =  UIColor.clear
        }
        
        
        if state != "ratio" {
            self.ratioupper.isHidden = true
            self.userratiopart.isHidden = true
        }
        else {
            self.ratioupper.isHidden = false
            self.userratiopart.isHidden = false
            self.userratiopart.text = "\(ratiopart)"
        }

        
        self.userimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
       
          if let myImage = UIImage(named: "user") {
                 let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                self.userimage.image = tintableImage
             }
        
        
    }
    
    func uideisgn()
    {
        self.imageouter.backgroundColor = UIColor.clear
        self.imageouter.layer.cornerRadius = 40
        self.imageouter.layer.shadowPath = UIBezierPath(rect: self.imageouter.bounds).cgPath
        self.imageouter.layer.shadowRadius = 25
        self.imageouter.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.imageouter.layer.shadowOpacity = 0.35
        self.imageouter.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.imageouter.clipsToBounds = true
        
        self.userimage.clipsToBounds = true
        

//        self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2
//        self.userimage.layer.borderWidth = 1
//        self.userimage.layer.borderColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        
             self.ratioupper.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
             self.amountheader.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
             self.userratiopart.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.username.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useramount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useramount.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.userallpaidconfirm.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.userallpaidconfirm.layer.borderWidth = 1
        self.userallpaidconfirm.backgroundColor = UIColor.clear
        self.userallpaidlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.useramount.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.userratiopart.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.useramount.layer.borderWidth = 1
        self.useramount.layer.cornerRadius = 10
        self.useramount.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        
        self.userratiopart.layer.borderWidth = 1
        self.useramount.layer.cornerRadius = 10
        self.userratiopart.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            self.passbackamount!(self.useramount.text ?? "" , self.currentuser?.id ?? "")
        }
        else if textField.tag == 2 {
            print(self.userratiopart.text)
            if let m = Int(self.userratiopart.text ?? "0") as? Int {
                self.takeratiopart!(m,self.currentuser?.id ?? "")
            }
        }
    }
    
    
    @IBAction func tappedwholebill(_ sender: Any) {
        print("hello bill amount is \(billtotalamount)")
        print("Current user value is \(self.currentuser?.billamountpaidinadvance)")
        var uv = 0
        if let v = self.currentdict["\(self.currentuser?.id)"] as? Int{
            uv = v
        }
        if uv != billtotalamount {
            userallpaidconfirm.backgroundColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.paidwholestatus!(true,self.currentuser?.id ?? "")
        }
        else {
            userallpaidconfirm.backgroundColor == UIColor.clear
            self.paidwholestatus!(false,self.currentuser?.id ?? "")
        }
    }
    
}
