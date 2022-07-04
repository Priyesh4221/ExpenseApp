//
//  AmountPaidViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class AmountPaidViewController: UIViewController , UITextFieldDelegate {

    var status = ""
    var passedcontact : contacts?
    var paidbyid = ""
    var receivedbyid = ""
    
    var transactionid = ""
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    
    
    @IBOutlet weak var youare: UILabel!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var cvstatus: UILabel!
    
    @IBOutlet weak var amtpaidlabel: UILabel!
    
    @IBOutlet weak var amtpaidvalue: CustomTextField!
    
    @IBOutlet weak var subjectlabel: UILabel!
    
    @IBOutlet weak var subjectvalue: CustomTextField!
    
    
    @IBOutlet weak var commentlabel: UILabel!
    
    @IBOutlet weak var commentvalue: CustomTextField!
    
    @IBOutlet weak var note1: UILabel!
    
    
    @IBOutlet weak var note2: UILabel!
    
    @IBOutlet weak var footerview: UIView!
    
    
    var passbackupdatedamount : ((_ x:contacts , _ y : String ) -> Void)?
    
    
    var newamountreflected : ((_ amount : String) -> Void)?
    
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
        self.navbar.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.scrollview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.footerview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        self.cvstatus.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.youare.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.amtpaidlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.subjectlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.commentlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.note1.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.note2.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.amtpaidvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amtpaidvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.amtpaidvalue.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.subjectvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.subjectvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.subjectvalue.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.commentvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.commentvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.commentvalue.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.youare.text = "You are : \(self.status.capitalized)"
        if self.passedcontact?.crossverification ?? false {
            self.cvstatus.text = "Cross verification : Active"
        }
        else {
            self.cvstatus.text = "Cross verification : Inactive"
        }
        
        amtpaidvalue.delegate = self
        subjectvalue.delegate = self
        commentvalue.delegate = self
        
        self.navbarhead.text = self.passedcontact?.name?.capitalized
        
        self.addbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                      if let myImage = UIImage(named: "backpdf") {
                                 let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                                 self.addbtn.setImage(tintableImage, for: .normal)
                             }

        
        // Do any additional setup after loading the view.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                amtpaidvalue.resignFirstResponder()
        subjectvalue.resignFirstResponder()
        commentvalue.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         amtpaidvalue.resignFirstResponder()
               subjectvalue.resignFirstResponder()
               commentvalue.resignFirstResponder()
    }
    
    

    let shapelayer = CAShapeLayer()
    let tracklayer = CAShapeLayer()
    
    func startloader()
    {
        let radius = self.view.frame.size.width/8
        let c = view.center.x
        let d = view.center.y*0.8 - radius
        let cen = CGPoint(x: c, y: d)
        
        let circularpath = UIBezierPath(arcCenter: cen, radius: radius, startAngle:  -CGFloat.pi/2, endAngle:2*CGFloat.pi, clockwise: true)
        print("loading")
        
        tracklayer.path = circularpath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeEnd = 10
        tracklayer.lineCap = kCALineCapRound
        tracklayer.strokeColor = hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        tracklayer.lineWidth = 6
        self.scrollview.layer.insertSublayer(tracklayer, at: 10)
        
        shapelayer.path = circularpath.cgPath
        shapelayer.fillColor = UIColor.clear.cgColor
        
        shapelayer.strokeEnd = 0
        shapelayer.lineCap = kCALineCapRound
        shapelayer.strokeColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        shapelayer.lineWidth = 6
        shapelayer.opacity = 0.8
        shapelayer.shadowColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        shapelayer.shadowOffset = CGSize(width: 0.6, height: 0.9)
        shapelayer.shadowOpacity = 0.8
        shapelayer.shadowRadius = 10
        self.scrollview.layer.insertSublayer(shapelayer, at: 10)
        
        let basicanimation = CABasicAnimation(keyPath: "strokeEnd")
        basicanimation.duration = 2
        
        basicanimation.toValue = 1
        basicanimation.repeatCount = Float.infinity
        shapelayer.add(basicanimation, forKey: "hello")
        
        
        
    }
    
    func unlockfields()
    {
        self.profilebtn.isEnabled = true
        self.amtpaidvalue.isEnabled = true
        self.subjectvalue.isEnabled = true
        self.commentvalue.isEnabled = true
    }
    
    
    func addrecentsentry()
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        var d : Dictionary<String,Any> = ["lastused" : FIRServerValue.timestamp() , "name" : self.passedcontact?.name ?? "" , "profileimage" : self.passedcontact?.profileimage ?? "" , "type" : "individual"]
        Dataservices.ds.users.child(userid).child("recents").child(self.passedcontact?.userid ?? "").setValue(d) { (err, ref) in
            if err == nil {
                HomescreenViewController.passedrecents!(true)
                var ot = ""
                if userid == self.paidbyid {
                    ot = self.receivedbyid
                }
                else {
                    ot = self.paidbyid
                }
                Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(ot).child("crossverification").observeSingleEvent(of: .value) { (kkl) in
                    if let kkt = kkl.value as? Bool {
                        var msg = ""
                        var data : Dictionary<String,Any> = [:]
                        if userid == self.paidbyid {
                            var name = ""
                            var amt = ""
                            var sub = ""
                            if let d = self.amtpaidvalue.text {
                                amt = d
                            }
                            if let s = self.subjectvalue.text {
                                sub = s
                            }
                            if let kk = KeychainWrapper.standard.string(forKey: "name") as? String {
                                name = kk
                            }
                            else {
                                name = "Priyesh"
                            }
                            msg = "\(name.capitalized) claims that he/she has paid \(amt) for you."
                             data  = ["category" : "individual", "content" : sub , "date" : FIRServerValue.timestamp() , "from" : userid , "matter" : msg , "needapproval" : kkt , "receipientresponded" : false, "referenceid" : self.transactionid , "type" : "approval"]
                        }
                        else if userid == self.receivedbyid {
                            var name = ""
                            var amt = ""
                            var sub = ""
                            if let d = self.amtpaidvalue.text {
                                amt = d
                            }
                            if let s = self.subjectvalue.text {
                                sub = s
                            }
                            if let kk = KeychainWrapper.standard.string(forKey: "name") as? String {
                                name = kk
                            }
                            else {
                                name = "Priyesh"
                            }
                            msg = "\(name.capitalized) claims that you have paid \(amt) for him/her."
                             data  = ["category" : "individual", "content" : sub , "date" : FIRServerValue.timestamp() , "from" : userid , "matter" : msg , "needapproval" : kkt , "receipientresponded" : false, "referenceid" : self.transactionid , "type" : "approval"]
                        }
                        
                        Dataservices.ds.users.child(ot).child("notifications").childByAutoId().setValue(data) { (err, ref) in
                            if err == nil {
                                Dataservices.ds.users.child(ot).child("unseennotificationscount").observeSingleEvent(of: .value) { (count) in
                                    if let cv = count.value as? Int {
                                        var newcv = cv + 1
                                        Dataservices.ds.users.child(ot).child("unseennotificationscount").setValue(newcv)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                
            }
        }
    }
    
    
    @IBAction func nextpressed(_ sender: UIButton) {
        
        self.profilebtn.isEnabled = false
        self.amtpaidvalue.isEnabled = false
        self.subjectvalue.isEnabled = false
        self.commentvalue.isEnabled = false
        
       
        
        if self.amtpaidvalue.text == "" || self.amtpaidvalue.text == " "
        {
            var x = Customalert.cs.showalert(x: "Invalid amount", y: "You need to enter amount for this transaction.")
            self.present(x, animated: true, completion: nil)
            unlockfields()
            return
        }
        
        var amt =  Double(self.amtpaidvalue.text!)
        
        if let aamt = amt as? Double {
            let alert = UIAlertController(title: "Confirm transaction", message: "Are you sure you want to add this transaction amounting to \(aamt)",preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.view.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            alert.modifyalertview()
            alert.addAction(UIAlertAction(title: "Yes Add this transaction", style: UIAlertActionStyle.default, handler: { _ in
                 self.startloader()
                var userid = KeychainWrapper.standard.string(forKey: "auth")!
                userid = "xytsha3527383"

                var data = FIRServerValue.timestamp()
                var subject = ""
                var comment = ""
                if let c = self.commentvalue.text as? String {
                    comment = c
                }
                if let s = self.subjectvalue.text as? String{
                    subject = s
                }
                var verified = ""
                if self.passedcontact?.crossverification == true {
                    verified = "pending"
                }
                else {
                    verified = "na"
                }
                print(data)
                var otherpserson = ""
                print("Check passed userid \(self.passedcontact?.userid)")
                if let id = self.passedcontact?.userid as? String {
                    if self.status.lowercased() == "payer"
                    {
                        self.receivedbyid = id
                        otherpserson = id
                        self.paidbyid = userid
                    }
                    else {
                        self.receivedbyid = userid
                        self.paidbyid = id
                        otherpserson = id
                    }
                }
                
                
                print("Right now amount is \(self.passedcontact?.amount)")
                
                
                
                
                

                var fkey = Dataservices.ds.users.child("\(userid)").child("transactions").childByAutoId().key
                self.transactionid = fkey
                Dataservices.ds.users.child("\(userid)").child("transactions").child(otherpserson).child(fkey).setValue(data) { (err, ref) in
                    if err == nil {
                        
                        Dataservices.ds.users.child("\(otherpserson)").child("transactions").child(userid).child(fkey).setValue(data) { (err, ref) in
                            if err == nil {
                        
                        
                                var post : Dictionary<String,Any> = ["category" : self.passedcontact?.type , "comment" : comment , "creator" : userid,"date" : data,"netamount" : aamt,"paidby" : self.paidbyid,"receivedby":self.receivedbyid,"subject":subject,"verified" : verified]

                        Dataservices.ds.home.child("transactions").child(fkey).setValue(post) { (err1, ref1) in
                            if err1 == nil {
                                

                                Dataservices.ds.users.child(userid).child("updates").child("transactionslastupdated").setValue(data) { (err2, ref2) in
                                    if err2 == nil {

                                        if let prevamt = self.passedcontact?.amount as? String {
                                            print("Prefix is \(prevamt.prefix(1))")
                                            if prevamt.prefix(1) == "+" {
                                                print("Check entering 11")
                                                var netamt = Double(prevamt.components(separatedBy: "+")[1])
                                                print("Net amt is \(netamt)")
                                                if let nam = netamt as? Double {
                                                    if self.paidbyid == userid {
                                                        print("Check entering 1")
                                                        var newamt = "+\(nam + aamt)"
                                                        var oppnewamt = "-\(nam + aamt)"
                                                        Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.receivedbyid)").child("netamount").setValue(newamt) { (err4, ref4) in
                                                            
                                                            if err4 != nil {
                                                                self.unlockfields()
                                                            }
                                                            
                                                            Dataservices.ds.users.child("\(self.receivedbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(oppnewamt) { (err5, ref4) in
                                                                
                                                                if err5 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                self.newamountreflected!(newamt)
                                                                self.addrecentsentry()
                                                                self.passedcontact?.amount = newamt
                                                                if let t = self.passedcontact {
                                                                    self.passbackupdatedamount!(t , newamt)
                                                                }
                                                                
                                                                let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                alert.modifyalertview()
                                                                
                                                                alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                
                                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                    //Cancel Action
                                                                    self.navigationController?.popViewController(animated: true)
//                                                                    self.dismiss(animated: true, completion: nil)
                                                                }))
                                                                
                                                                self.present(alert, animated: true, completion: nil)

                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                        print("New amt is \(newamt)")
                                                        
                                                    }
                                                    else {
                                                        print("Check entering 2")
                                                        var newamt = nam - aamt
                                                        print("New amt is \(newamt)")
                                                        if newamt > 0 {
                                                            var tamt = "+\(newamt)"
                                                            var opptamt = "-\(newamt)"
                                                            print("tamt amt is \(tamt)")
                                                            Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.paidbyid)").child("netamount").setValue(tamt) { (err4, ref4) in
                                                                
                                                                if err4 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                Dataservices.ds.users.child("\(self.paidbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(opptamt) { (err5, ref4) in
                                                                    
                                                                    if err5 != nil {
                                                                        self.unlockfields()
                                                                    }
                                                                    
                                                                    self.newamountreflected!(tamt)
                                                                    self.addrecentsentry()
                                                                    self.passedcontact?.amount = tamt
                                                                    if let t = self.passedcontact {
                                                                        self.passbackupdatedamount!(t , tamt)
                                                                    }
                                                                    let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                    
                                                                    alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                    
                                                                    alert.modifyalertview()
                                                                    
                                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                        //Cancel Action
                                                                        self.navigationController?.popViewController(animated: true)
//                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }))
                                                                    
                                                                    
                                                                    self.present(alert, animated: true, completion: nil)

                                                                }
                                                                
                                                                
                                                            }

                                                        }
                                                        else {
                                                            var tmt = "-\(newamt.magnitude)"
                                                            var opptmt = "+\(newamt.magnitude)"
                                                            print("tmt amt is \(tmt)")
                                                            Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.paidbyid)").child("netamount").setValue(tmt) { (err4, ref4) in
                                                                
                                                                if err4 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                Dataservices.ds.users.child("\(self.paidbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(opptmt) { (err5, ref4) in
                                                                    self.newamountreflected!(tmt)
                                                                    
                                                                    if err5 != nil {
                                                                        self.unlockfields()
                                                                    }

                                                                    self.addrecentsentry()
                                                                    self.passedcontact?.amount = tmt
                                                                    if let t = self.passedcontact {
                                                                        self.passbackupdatedamount!(t , tmt)
                                                                    }
                                                                    let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                    
                                                                    alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                    
                                                                    alert.modifyalertview()
                                                                    
                                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                        //Cancel Action
                                                                        self.navigationController?.popViewController(animated: true)
//                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }))
                                                                    
                                                                    self.present(alert, animated: true, completion: nil)

                                                                    
                                                                }
                                                                
                                                                
                                                            }

                                                        }
                                                    }
                                                }
                                            }
                                            else if prevamt.prefix(1) == "-" {
                                                print("Check entering 33")
                                                var netamt = Double(prevamt.components(separatedBy: "-")[1])
                                                print("Net amt is \(netamt)")
                                                if let nam = netamt as? Double {
                                                    if self.paidbyid != userid {
                                                        print("Check entering 3")
                                                        var newamt = "-\(nam + aamt)"
                                                        var oppnewamt  = "+\(nam + aamt)"
                                                        print("New amt is \(newamt)")
                                                        Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.paidbyid)").child("netamount").setValue(newamt) { (err4, ref4) in
                                                            
                                                            if err4 != nil {
                                                                self.unlockfields()
                                                            }
                                                            
                                                            Dataservices.ds.users.child("\(self.paidbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(oppnewamt) { (err5, ref4) in
                                                                
                                                                
                                                                if err5 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                self.newamountreflected!(newamt)

                                                                self.addrecentsentry()
                                                                self.passedcontact?.amount = newamt
                                                                if let t = self.passedcontact {
                                                                    self.passbackupdatedamount!(t , newamt)
                                                                }
                                                                let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                
                                                                alert.modifyalertview()
                                                                
                                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                    //Cancel Action
                                                                    self.navigationController?.popViewController(animated: true)
//                                                                    self.dismiss(animated: true, completion: nil)
                                                                }))
                                                                self.present(alert, animated: true, completion: nil)
                                                                
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        }

                                                    }
                                                    else {
                                                        print("Existing amount \(self.passedcontact?.amount)")
                                                        print("Check entering 4 \(nam) \(aamt)")
                                                        var newamt = nam - aamt
                                                        print("New amt is \(newamt)")
                                                        if newamt > 0 {
                                                            var tamt = "-\(newamt)"
                                                            var opptamt = "+\(newamt)"
                                                            print("tamt amt is \(tamt)")
                                                            Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.receivedbyid)").child("netamount").setValue(tamt) { (err4, ref4) in
                                                                
                                                                if err4 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                Dataservices.ds.users.child("\(self.receivedbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(opptamt) { (err5, ref4) in
                                                                    
                                                                    
                                                                    if err5 != nil {
                                                                        self.unlockfields()
                                                                    }
                                                                    
                                                                    self.newamountreflected!(tamt)

                                                                    self.addrecentsentry()
                                                                    self.passedcontact?.amount = tamt
                                                                    if let t = self.passedcontact {
                                                                        self.passbackupdatedamount!(t , tamt)
                                                                    }
                                                                    let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                    alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                    
                                                                    alert.modifyalertview()
                                                                    
                                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                        //Cancel Action
                                                                        self.navigationController?.popViewController(animated: true)
//                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }))
                                                                    self.present(alert, animated: true, completion: nil)

                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                            }

                                                        }
                                                        else {
                                                            var tmt = "+\(newamt.magnitude)"
                                                            var opptmt = "-\(newamt.magnitude)"
                                                            print("tmt amt is \(tmt)")
                                                            Dataservices.ds.users.child("\(userid)").child("contacts").child("individuals").child("\(self.receivedbyid)").child("netamount").setValue(tmt) { (err4, ref4) in
                                                                
                                                                
                                                                if err4 != nil {
                                                                    self.unlockfields()
                                                                }
                                                                
                                                                Dataservices.ds.users.child("\(self.receivedbyid)").child("contacts").child("individuals").child("\(userid)").child("netamount").setValue(opptmt) { (err5, ref4) in
                                                                    
                                                                    
                                                                    if err5 != nil {
                                                                        self.unlockfields()
                                                                    }
                                                                    
                                                                    self.newamountreflected!(tmt)

                                                                    self.addrecentsentry()
                                                                    self.passedcontact?.amount = tmt
                                                                    if let t = self.passedcontact {
                                                                        self.passbackupdatedamount!(t , tmt)
                                                                    }
                                                                    let alert = UIAlertController(title: "Transaction Added", message: "",preferredStyle: UIAlertControllerStyle.alert)
                                                                    alert.view.tintColor = self.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                                                                    
                                                                    alert.modifyalertview()
                                                                    
                                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                                                                        //Cancel Action
                                                                        self.navigationController?.popViewController(animated: true)
//                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }))
                                                                    
                                                                    self.present(alert, animated: true, completion: nil)

                                                                    
                                                                }
                                                                
                                                                
                                                            }

                                                        }
                                                    }
                                                }
                                            }
                                        }



                                    }
                                    else {
                                        self.unlockfields()
                                    }
                                }
                            }
                                
                            else {
                                self.unlockfields()
                                print(err1.debugDescription)
                            }
                        }


                 
        
                
                
                

                
                
                
                
                            }
                            }
                    }
                    else {
                        self.unlockfields()
                    }
                    }
                
                
            }))
            alert.addAction(UIAlertAction(title: "No Cancel this transaction", style: UIAlertActionStyle.cancel, handler: { _ in
                //Cancel Action
            }))
            self.present(alert, animated: true, completion: nil)
    }
        else {
            var x = Customalert.cs.showalert(x: "Invalid amount", y: "You need to enter amount which is numeric.")
            unlockfields()
            self.present(x, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    

}
