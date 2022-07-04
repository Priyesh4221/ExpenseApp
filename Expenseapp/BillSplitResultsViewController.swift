//
//  BillSplitResultsViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 4/12/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class BillSplitResultsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var firstview: UIView!
    
    
    @IBOutlet weak var profileimagewrapper: UIView!
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var billcreatedby: UILabel!
    
    @IBOutlet weak var billcreator: UILabel!
    
    
    @IBOutlet weak var billdate: UILabel!
    
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var layerview: UIView!
    
    @IBOutlet weak var billsplitedlabel: UILabel!
    
    @IBOutlet weak var billinfo1label: UILabel!
    
    @IBOutlet weak var splitamonglabel: UILabel!
    
    
    @IBOutlet weak var bottomview: UIView!
    
    var currentbill : billsplittransaction?
    
    
    @IBOutlet weak var submitbill: UIButton!
    
    @IBOutlet weak var collection: UICollectionView!
    var splittedbillamount : Dictionary<String,Int> = [:]
    var billingamountbefore : Dictionary<String,Int> = [:]
    var billingamountlefttopay : Dictionary<String,Int> = [:]
    var ratiosplit : Dictionary<String,Int> = [:]

    
    var allusersforbill : [user] = []
    
    
    

    
    
    
    
    
    var crossverification : Dictionary<String,String> = [:]

    
    
    
    
    
    
    var mode = ""
    var state = ""
    
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
        
        
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.billsplitedlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
   
        self.splitamonglabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
       
        
        self.submitbill.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.submitbill.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.firstview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.firstview.layer.cornerRadius = 10
        self.billcreatedby.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.billcreator.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.billdate.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
       
        
        self.profileimagewrapper.backgroundColor = UIColor.clear
        self.profileimagewrapper.layer.cornerRadius = 40
        self.profileimagewrapper.layer.shadowPath = UIBezierPath(rect: self.profileimagewrapper.bounds).cgPath
        self.profileimagewrapper.layer.shadowRadius = 25
        self.profileimagewrapper.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.profileimagewrapper.layer.shadowOpacity = 0.35
        self.profileimagewrapper.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        self.profileimagewrapper.clipsToBounds = true
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        
        
        
        
        
        self.backbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
       
        
        
        self.bottomview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        
    }
    
    
    
    @IBAction func nextbtnpressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backhome", sender: nil)
    }
    
    
    
    
    
    
    func postbill()
    {
        
        for each in allusersforbill {
            if each.status == "phone" || each.status == "guest" {
                crossverification[each.id] = "not applicable"
            }
            else {
                crossverification[each.id] = "pending"
            }
        }
        
        
        print(self.billingamountbefore)
        print(self.billingamountlefttopay)
        print(currentbill)
        
        var comm  = ""
        if let c = currentbill?.comment as? String {
            comm = c
        }
        var am = 0
        if let c = Int(currentbill?.amount ?? 0) as? Int {
            am = c
        }
        
        
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
          userid = "xytsha3527383"
        var d = Date().description
        var tmp = FIRServerValue.timestamp()
        var userdictionary : Dictionary<String,Any> = [:]
        
        for each in self.billingamountbefore {
            var m : [Dictionary<String,Any>] = []
            var n : [Dictionary<String,Any>] = []
            var o : [Dictionary<String,Any>] = []
            var iid = ""
            var aa = 0
            var bb = 0
            var cc = 0
            if let a = self.splittedbillamount[each.key] as? Int {
                aa = a
            }
            if let a = self.billingamountbefore[each.key] as? Int {
                bb = a
            }
            if let a = self.billingamountlefttopay[each.key] as? Int {
                cc = a
            }
            
            m.append(["\(d)":aa])
            n.append(["\(d)":bb])
            o.append(["\(d)":cc])
            
            var splitratio = 1
            if let b = ratiosplit[each.key] as? Int {
                splitratio = b
            }
            
            var cv = ""
            if let m = crossverification[each.key] as? String {
                cv = m
            }
            
            
            var yy : Dictionary<String,Any> = ["amountafterspliting" : m , "paidadvance" : n, "paymentleft" : o , "splitratio" : splitratio , "verified" : "\(cv)"]
            userdictionary[each.key] = yy
        }
        
        
        var x : Dictionary<String,Any> = ["category" : "billsplit","comment" : "\(comm)","creator" : "\(userid)" ,"date" : "\(d)","netamount" : am , "subject" : "\(comm)" , "receipients" : userdictionary ]
        
        
        
        Dataservices.ds.billsplits.childByAutoId().setValue(x) { (err, ref) in
            if err == nil {
                self.tracklayer.removeAllAnimations()
                self.shapelayer.removeAllAnimations()
                self.tracklayer.isHidden = true
                self.shapelayer.isHidden = true
                self.collection.isHidden = false
                self.billsplitedlabel.text = "Bill Splitted !"
                self.billcreator.text = "\(comm.capitalized)"
                self.billdate.text = "\(d)"
                self.firstview.isHidden = false
                self.updatesidedata(x : d , y : ref.key)
            }
        }
    }
    
    
    func updatesidedata(x : String , y : String)
    {
        print("Hollaaaaaaaaaaaaaaa")
        print(y)
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        
        
        
        var username = ""
        var userimage = ""
        
        Dataservices.ds.users.child(userid).child("basic").observeSingleEvent(of: .value) { (usnao) in
            if let uusn = usnao.value as? Dictionary<String,Any> {
                if let c = uusn["name"] as? String {
                    username = c
                }
                if let c = uusn["profileimage"] as? String {
                    userimage = c
                }
                
                
                
                
            }
            
            var datatoput  : Dictionary<String,Any> = ["category" : "billsplit" , "content" : "You have been added into a billsplit by \(username.capitalized)" , "date" : FIRServerValue.timestamp(), "from" : "\(userid)","matter" : "","needapproval" : true , "receipientresponded" : false,"referenceid" : "\(y)" , "status" : "yes","type": "approval"]
            
            var recents : Dictionary<String,Any> = ["lastused" : FIRServerValue.timestamp(),"name" :"\(username)","profileimage" : "\(userimage)","type" : "billsplit"]
            
            for each in self.billingamountbefore {
                var matter = ""
                var tty = self.billingamountlefttopay[each.key]
                print("Check \(each.key) is paying \(tty)")
                
                if self.crossverification[each.key] != "not applicable" {
                    Dataservices.ds.users.child(each.key).child("billsplits").child(y).setValue(FIRServerValue.timestamp()) { (err, r) in
                        if err == nil {
                            Dataservices.ds.users.child(each.key).child("updates").child("billsplitslastupdated").setValue(x)
                            Dataservices.ds.users.child(each.key).child("notifications").childByAutoId().setValue(datatoput) { (errn, red) in
                                if errn == nil {
                                    Dataservices.ds.users.child(each.key).child("unseennotificationscount").observeSingleEvent(of: .value) { (snot) in
                                        if let snottt = snot.value as? Int {
                                            Dataservices.ds.users.child(each.key).child("unseennotificationscount").setValue(snottt + 1) { (errsn, refsn) in
                                                if errsn == nil {
                                                    Dataservices.ds.users.child(each.key).child("recents").child(y).setValue(recents) { (finalerr, finalref) in
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
        startloader()
    }
    
    
    let shapelayer = CAShapeLayer()
    let tracklayer = CAShapeLayer()

    
    func startloader()
    {
        let radius = self.view.frame.size.width/8
        let c = view.center.x
        let d = view.center.y/2 - radius
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
    
    var generatedamounts : Dictionary<String,Double> = [ : ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startloader()
        self.billsplitedlabel.text = "Please Wait"
        self.navbarhead.text = self.currentbill?.billname
//        self.layerview.isHidden = true
        self.collection.delegate = self
        self.collection.dataSource = self
        self.submitbill.layer.cornerRadius = 25
        self.collection.isHidden = true
        print("-----------------------")
        print(self.currentbill)
        self.firstview.isHidden = true
        self.collection.reloadData()
//        registerphonecontactsasguestuser()
        self.postbill()
        
//        if let am = self.currentbill?.amount as? Double {
//            if self.mode == "fixed" && self.state == "equal" && self.currentbill?.receipients?.count ?? 0 > 0 {
//                var indi = (self.currentbill?.amount ?? 0) / Double(self.currentbill?.receipients?.count ?? 1)
//                print("----------------")
//                print(indi)
//                if let users  = self.currentbill?.receipients as? [user] {
//
////                    for each in users {
////                        var iid = ""
////                        if let i = each.id as? String {
////                            self.splittedbillamount["\(i)"] = Int(indi)
////                        }
////                        self.currentbill?.billamountsgenerated.append(indi)
////                    }
//                    print("--------------------")
//                    print(self.currentbill)
//
//                }
//            }
//
//        }

        // Do any additional setup after loading the view.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentbill?.receipients?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "billsplit", for: indexPath) as? BillsplitresultCollectionViewCell {
            
            print(self.billingamountbefore)
            
            
            var curr = self.currentbill?.receipients?[indexPath.row]
            var iid = ""
            if let i = curr?.id as? String {
                iid = i
            }
            print(iid)
            print(self.billingamountbefore["\(iid)"])
            var bills = self.currentbill?.billamountsgenerated
            var alreadypaid = self.billingamountbefore["\(iid)"] ?? 0
            var lefttopay = self.billingamountlefttopay["\(iid)"] ?? 0
            var share = self.splittedbillamount["\(iid)"] ?? 0
            
                
            cell.update(x : self.currentbill?.receipients?[indexPath.row] ?? user(name: "", id: "", selected: false, email: "", mobile: "", gender: "", profileimage: "", status: "", currency: "") , y : share , a: alreadypaid ?? 0 , b : lefttopay)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width * 0.75, height: self.collection.frame.size.height)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? HomescreenViewController {
            seg.allrecents = []
            seg.fetchdummuydata()
        }
    }
   

}



extension UITextField {
    func xyz()
    {
        self.enablesReturnKeyAutomatically = true
    }
}
