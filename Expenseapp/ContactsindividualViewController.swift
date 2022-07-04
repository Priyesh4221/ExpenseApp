//
//  ContactsindividualViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/23/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ContactsindividualViewController: UIViewController {
    
    
    var passbackupdatedamount : ((_ x:contacts , _ y : String ) -> Void)?
    
    @IBOutlet weak var profileouterview: UIView!
    
    var passedcontact : contacts!
    var justcontactuserid : String?
    
    var refreshdata : ((_ refresh : Bool) -> Void)?
    
    var dangeringoingback = false
    

    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var userprofilepic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var usertype: UILabel!
    
    @IBOutlet weak var paymentsummary: UILabel!
    
    @IBOutlet weak var addtransactionheading: UILabel!
    
    @IBOutlet weak var receivingbtn: UIButton!
    @IBOutlet weak var sendingbtn: UIButton!
    @IBOutlet weak var navbarbg: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var contactsheading: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    
    @IBOutlet weak var profilebutton: UIButton!
    
    
    @IBOutlet weak var viewprevtransactionsbuttons: UIButton!
    
    
    var currentname  = ""
    
    
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
    
    func setupcolors()
    {
        self.navbarbg.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.scrollview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.contactsheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbutton.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebutton.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
         self.username.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.usertype.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.paymentsummary.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.addtransactionheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.receivingbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.receivingbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.sendingbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.sendingbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.viewprevtransactionsbuttons.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.viewprevtransactionsbuttons.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
        
        self.userprofilepic.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
       
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = passedcontact as? contacts {
            self.contactsheading.text = self.passedcontact.name?.capitalized
            self.username.text = self.passedcontact.name?.capitalized
            self.usertype.text = self.passedcontact.type?.capitalized
            var str = ""
            var name = ""
            if let n = self.passedcontact.name as? String {
                name = n
                currentname = name
            }
            if(self.passedcontact.amount?.hasPrefix("-"))!
            {
                if let t = self.passedcontact.amount?.split(separator: "-").last
                {
                str = "You will pay Rs \(t) to \(name.capitalized)"
                }
                print("A")
            }
            else if(self.passedcontact.amount?.hasPrefix("+"))!
            {
                if let t = self.passedcontact.amount?.split(separator: "+").last
                {
                    str = "You will receive Rs \(t) from \(name.capitalized)"
                }
                
                print("B")
            }
            else
            {
                str = "You will receive Rs \(self.passedcontact.amount!) from \(name.capitalized)"
                print("C")
            }
            self.paymentsummary.text = str
            
            self.sendingbtn.setTitle("You paying for \(name.capitalized)", for: .normal)
            self.receivingbtn.setTitle("\(name.capitalized) paying for You", for: .normal)
            
        }
        else if let sid = self.justcontactuserid as? String {
            var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
            userid = "xytsha3527383"
            Dataservices.ds.users.child(sid).child("basic").observeSingleEvent(of: .value) { (ss) in

                
                if let snap = ss.value as? Dictionary<String,Any> {
                    var n = ""
                    var e = ""
                    var p = ""
                    var s = ""
                    var g = ""
                    var cu = ""
                    var amt = ""
                    var cv = ""
                    var cvresult = false
                    var type = "individual"
                  
                    
                   

                        
                        
                        if let  name = snap["name"] as? String {
                            n = name
                        }
                        if let email = snap["email"] as? String {
                            e = email
                        }
                        if let  profileimage = snap["profileimage"] as? String {
                            p = profileimage
                        }
                        if let status = snap["status"] as? String {
                            s = status
                        }
                        if let gender = snap["gender"] as? String {
                            g = gender
                        }
                        if let currency = snap["currency"] as? String {
                            cu = currency
                        }
                    
                    
                    Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(self.justcontactuserid ?? "").observeSingleEvent(of: .value) { (sj) in
                        if let sk = sj.value as? Dictionary<String,Any> {
                            if let am = sk["crossverification"] as? String {
                                cv = am
                            }
                            if cv == "yes" || cv == "true" {
                                cvresult = true
                            }
                            else {
                                cvresult = false
                            }
                            if let am = sk["netamount"] as? String {
                                amt = am
                            }
                        }
    
                               var c = contacts(name: n, type: type, amount: "\(amt)", userid: sid, profileimage: p , gender: g, email: e, status:s, currency:cu ,crossverification : cvresult )
                         self.passedcontact = c
                               
                               self.contactsheading.text = c.name?.capitalized
                               self.username.text = c.name?.capitalized
                               self.usertype.text = c.type?.capitalized
                               var str = ""
                               var name = ""
                               if let n = c.name as? String {
                                   name = n
                                   self.currentname = name
                               }
                               if(c.amount?.hasPrefix("-"))!
                               {
                                   if let t = c.amount?.split(separator: "-").last
                                   {
                                   str = "You will pay Rs \(t) to \(name.capitalized)"
                                   }
                                   print("A")
                               }
                               else if(c.amount?.hasPrefix("+"))!
                               {
                                   if let t = c.amount?.split(separator: "+").last
                                   {
                                       str = "You will receive Rs \(t) from \(name.capitalized)"
                                   }
                                   
                                   print("B")
                               }
                               else
                               {
                                   str = "You will receive Rs \(c.amount!) from \(name.capitalized)"
                                   print("C")
                               }
                               self.paymentsummary.text = str
                               
                               self.sendingbtn.setTitle("You paying for \(name.capitalized)", for: .normal)
                               self.receivingbtn.setTitle("\(name.capitalized) paying for You", for: .normal)
                    }
 
                    
                }
                else {
                    var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
                    userid = "xytsha3527383"
                    Dataservices.ds.users.child(userid).child("guestusers").child(self.justcontactuserid ?? "").observeSingleEvent(of: .value) { (snapp) in
                        if let snap = snapp.value as? Dictionary<String,Any> {
                              var n = ""
                              var e = ""
                              var p = ""
                              var s = ""
                              var g = ""
                              var cu = ""
                              var amt = ""
                              var cv = ""
                              var cvresult = false
                              var type = "individual"
        
                              
                            if let am = snap["name"] as? String {
                                n = am
                            }
                            
                            
                            Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(self.justcontactuserid ?? "").observeSingleEvent(of: .value) { (sn) in
                                if let st = sn.value as? Dictionary<String,Any> {
                                    if let am = st["crossverification"] as? String {
                                        cv = am
                                    }
                                    if cv == "yes" || cv == "true" {
                                        cvresult = true
                                    }
                                    else {
                                        cvresult = false
                                    }
                                    if let am = st["netamount"] as? String {
                                        amt = am
                                    }
                                    var c = contacts(name: n, type: type, amount: "\(amt)", userid: sid, profileimage: p , gender: g, email: e, status:s, currency:cu ,crossverification : cvresult )
                                    self.passedcontact = c
                                    
                                    self.contactsheading.text = c.name?.capitalized
                                    self.username.text = c.name?.capitalized
                                    self.usertype.text = c.type?.capitalized
                                    var str = ""
                                    var name = ""
                                    if let n = c.name as? String {
                                        name = n
                                        self.currentname = name
                                    }
                                    if(c.amount?.hasPrefix("-"))!
                                    {
                                        if let t = c.amount?.split(separator: "-").last
                                        {
                                        str = "You will pay Rs \(t) to \(name.capitalized)"
                                        }
                                        print("A")
                                    }
                                    else if(c.amount?.hasPrefix("+"))!
                                    {
                                        if let t = c.amount?.split(separator: "+").last
                                        {
                                            str = "You will receive Rs \(t) from \(name.capitalized)"
                                        }
                                        
                                        print("B")
                                    }
                                    else
                                    {
                                        str = "You will receive Rs \(c.amount!) from \(name.capitalized)"
                                        print("C")
                                    }
                                    self.paymentsummary.text = str
                                    
                                    self.sendingbtn.setTitle("You paying for \(name.capitalized)", for: .normal)
                                    self.receivingbtn.setTitle("\(name.capitalized) paying for You", for: .normal)
                                }
                            }
                            

                              
                          }
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
        
        
        self.profileouterview.backgroundColor = UIColor.clear
        self.profileouterview.layer.cornerRadius = 45
        self.profileouterview.layer.shadowPath = UIBezierPath(rect: self.profileouterview.bounds).cgPath
        self.profileouterview.layer.shadowRadius = 25
        self.profileouterview.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.profileouterview.layer.shadowOpacity = 0.35
        self.profileouterview.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor

        self.profileouterview.clipsToBounds = true
        
        
        self.addbutton.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.addbutton.setImage(tintableImage, for: .normal)
        }

        
        self.userprofilepic.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                      
                      
                        if let myImage = UIImage(named: "user") {
                               let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                              self.userprofilepic.image = tintableImage
                           }
                      
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var status = ""
    
    @IBAction func sendingbtnpressed(_ sender: Any) {
        status = "payer"
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "amp") as! AmountPaidViewController
                vc.status = self.status
                vc.passedcontact = self.passedcontact
            
            vc.passbackupdatedamount = { a,b in
                         self.passedcontact.amount = b
                         self.passbackupdatedamount!(a,b)
                     }
            
                vc.newamountreflected = {a in
                    
                    print("Got New Amount \(a)")
                    var str = ""
                    if(a.hasPrefix("-"))
                    {
                        if let t = a.split(separator: "-").last
                        {
                            str = "You will pay Rs \(t) to \(self.currentname.capitalized)"
                        }
                        print("A")
                    }
                    else if(a.hasPrefix("+"))
                    {
                        if let t = a.split(separator: "+").last
                        {
                            str = "You will receive Rs \(t) from \(self.currentname.capitalized)"
                        }
                        
                        print("B")
                    }
                    else
                    {
                        str = "You will receive Rs \(a) from \(self.currentname.capitalized)"
                        print("C")
                    }
                    self.paymentsummary.text = str
                    self.refreshdata?(true)
                }

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = AmountPaidViewController()
                vc.status = self.status
                vc.passedcontact = self.passedcontact
            
            vc.passbackupdatedamount = { a,b in
                         self.passedcontact.amount = b
                         self.passbackupdatedamount!(a,b)
                     }
            
                vc.newamountreflected = {a in
                    
                    print("Got New Amount \(a)")
                    var str = ""
                    if(a.hasPrefix("-"))
                    {
                        if let t = a.split(separator: "-").last
                        {
                            str = "You will pay Rs \(t) to \(self.currentname.capitalized)"
                        }
                        print("A")
                    }
                    else if(a.hasPrefix("+"))
                    {
                        if let t = a.split(separator: "+").last
                        {
                            str = "You will receive Rs \(t) from \(self.currentname.capitalized)"
                        }
                        
                        print("B")
                    }
                    else
                    {
                        str = "You will receive Rs \(a) from \(self.currentname.capitalized)"
                        print("C")
                    }
                    self.paymentsummary.text = str
                    self.refreshdata?(true)
                }

            self.navigationController?.pushViewController(vc, animated: true)
        }
//        performSegue(withIdentifier: "enteramount", sender: nil)
    }
    
    
    @IBAction func receivingbtnpressed(_ sender: UIButton) {
        status = "receiver"
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "amp") as! AmountPaidViewController
                vc.status = self.status
                vc.passedcontact = self.passedcontact
            
            vc.passbackupdatedamount = { a,b in
                         self.passedcontact.amount = b
                         self.passbackupdatedamount?(a,b)
                     }
            
                vc.newamountreflected = {a in
                    
                    print("Got New Amount \(a)")
                    var str = ""
                    if(a.hasPrefix("-"))
                    {
                        if let t = a.split(separator: "-").last
                        {
                            str = "You will pay Rs \(t) to \(self.currentname.capitalized)"
                        }
                        print("A")
                    }
                    else if(a.hasPrefix("+"))
                    {
                        if let t = a.split(separator: "+").last
                        {
                            str = "You will receive Rs \(t) from \(self.currentname.capitalized)"
                        }
                        
                        print("B")
                    }
                    else
                    {
                        str = "You will receive Rs \(a) from \(self.currentname.capitalized)"
                        print("C")
                    }
                    self.paymentsummary.text = str
                    self.refreshdata?(true)
                }

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = AmountPaidViewController()
                vc.status = self.status
                vc.passedcontact = self.passedcontact
            
            
            vc.passbackupdatedamount = { a,b in
                self.passedcontact.amount = b
                self.passbackupdatedamount!(a,b)
            }
            
            
            
                vc.newamountreflected = {a in
                    
                    print("Got New Amount \(a)")
                    var str = ""
                    if(a.hasPrefix("-"))
                    {
                        if let t = a.split(separator: "-").last
                        {
                            str = "You will pay Rs \(t) to \(self.currentname.capitalized)"
                        }
                        print("A")
                    }
                    else if(a.hasPrefix("+"))
                    {
                        if let t = a.split(separator: "+").last
                        {
                            str = "You will receive Rs \(t) from \(self.currentname.capitalized)"
                        }
                        
                        print("B")
                    }
                    else
                    {
                        str = "You will receive Rs \(a) from \(self.currentname.capitalized)"
                        print("C")
                    }
                    self.paymentsummary.text = str
                    self.refreshdata?(true)
                }

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        performSegue(withIdentifier: "enteramount", sender: nil)
    }
    
    @IBAction func viewprevtransactionpressed(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "prev") as! PrevioustransactionsViewController
            vc.passedcontact = self.passedcontact
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = PrevioustransactionsViewController()
            vc.passedcontact = self.passedcontact
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
//        performSegue(withIdentifier: "transactioninfo", sender: nil)
    }
    
    @IBAction func profilepressed(_ sender: UIButton) {
    }
    
    
    @IBAction func addbtnpressed(_ sender: UIButton) {
        if dangeringoingback {
             if let u = KeychainWrapper.standard.string(forKey: "auth") as? String {
                       if #available(iOS 13.0, *) {
                           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CustomTabBarViewController") as! CustomTabBarViewController
                           self.navigationController?.pushViewController(vc, animated: true)
                       } else {
                           // Fallback on earlier versions
                           let vc = CustomTabBarViewController()
                           self.navigationController?.pushViewController(vc, animated: true)
                       }
                   }
//            self.performSegue(withIdentifier: "gobackhome", sender: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let seg = segue.destination as? PrevioustransactionsViewController
        {
            if segue.identifier == "transactioninfo"
            {
                seg.passedcontact = self.passedcontact
            }
        }
        else if let seg = segue.destination as? AmountPaidViewController
       {
            seg.status = self.status
            seg.passedcontact = self.passedcontact
        
            seg.newamountreflected = {a in
                
                print("Got New Amount \(a)")
                var str = ""
                if(a.hasPrefix("-"))
                {
                    if let t = a.split(separator: "-").last
                    {
                        str = "You will pay Rs \(t) to \(self.currentname.capitalized)"
                    }
                    print("A")
                }
                else if(a.hasPrefix("+"))
                {
                    if let t = a.split(separator: "+").last
                    {
                        str = "You will receive Rs \(t) from \(self.currentname.capitalized)"
                    }
                    
                    print("B")
                }
                else
                {
                    str = "You will receive Rs \(a) from \(self.currentname.capitalized)"
                    print("C")
                }
                self.paymentsummary.text = str
                self.refreshdata?(true)
            }
        
        }
    }
    

}
