//
//  ShowIndividualBillViewController.swift
//  Expenseapp
//
//  Created by admin on 19/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class ShowIndividualBillViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    

    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var firstview: UIView!
    
    @IBOutlet weak var billname: UILabel!
    
    
    @IBOutlet weak var bottomview: UIView!
    
    @IBOutlet weak var profileimagewrapper: UIView!
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var billcreatedbylabel: UILabel!
    
    @IBOutlet weak var billcreator: UILabel!
    
    @IBOutlet weak var billcreatedon: UILabel!
    
    
    @IBOutlet weak var billamount: UILabel!
    
    @IBOutlet weak var billsubject: UILabel!
    
    
    @IBOutlet weak var splittedamonglabel: UILabel!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    var passedbill : billshow?
    
    var passbackbill : ((_ x : billshow) -> Void)?
    
    
    var passedbillid = ""
    var passingwihtoutdata = false
    
    var currentbill : billsplittransaction?
    var splittedbillamount : Dictionary<String,Int> = [:]
    var billingamountbefore : Dictionary<String,Int> = [:]
    var billingamountlefttopay : Dictionary<String,Int> = [:]
    var ratiosplit : Dictionary<String,Int> = [:]

    var mode = ""
     var state = ""
    var allusersforbill : [user] = []
     var crossverification : Dictionary<String,String> = [:]
    var comingrightaftercreating = false
    
    
    
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
    
    
    func setupcolor()
    {
        self.upperview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.firstview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.firstview.layer.cornerRadius = 10
        self.billname.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.billcreatedbylabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.billcreator.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.billcreatedon.textColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.billamount.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.billsubject.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.splittedamonglabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.profileimagewrapper.backgroundColor = UIColor.clear
        self.profileimagewrapper.layer.cornerRadius = 40
        self.profileimagewrapper.layer.shadowPath = UIBezierPath(rect: self.profileimagewrapper.bounds).cgPath
        self.profileimagewrapper.layer.shadowRadius = 25
        self.profileimagewrapper.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.profileimagewrapper.layer.shadowOpacity = 0.35
        self.profileimagewrapper.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        self.profileimagewrapper.clipsToBounds = true
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolor()
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.backbtn.setImage(tintableImage, for: .normal)
        }
        collection.delegate = self
        collection.dataSource = self
        if self.passedbill?.creatorid == "TzWWUWB6iFXBx2aXlx1FitcheYh2" {
            passedbill?.creatorid = "xytsha3527383"
        }
        
       
        if passingwihtoutdata == false {
        
        if comingrightaftercreating  {
            self.postbill()
        }
        else {
            getinitial(id: self.passedbill?.creatorid ?? "") { (a, b, c) in
                self.passedbill?.creatorname = b
                self.passedbill?.creatorimagelink = c
                self.billcreator.text = b.capitalized
                self.billcreatedon.text = self.presentdatebetter(x : self.passedbill?.date ?? "")
                self.billamount.text = "Rs \(self.passedbill?.netamount ?? 0)"
                self.billsubject.text = "Subject : \(self.passedbill?.subject.capitalized ?? "")"
                //            self.collection.reloadData()
                if var allusers = self.passedbill?.receipients as? [billshowreceipients] {
                    var tmp = 0
                    for each in 0 ..< allusers.count {
                        var tmpp = ""
                        if allusers[each].userid == "TzWWUWB6iFXBx2aXlx1FitcheYh2" {
                            tmpp = "xytsha3527383"
                        }
                        else {
                            tmpp = allusers[each].userid
                        }
                        self.getinitial(id: tmpp) { (a, b, c) in
                            
                            self.passedbill?.receipients[each].username = b
                            self.passedbill?.receipients[each].userimage = c
                            tmp = tmp + 1
                            if tmp == allusers.count {
                                self.collection.reloadData()
                                print("Here is all receipients")
                                print(self.passedbill?.receipients)
                                self.passbackbill!(self.passedbill!)
                            }
                        }
                    }
                }
                
                
                
                
            }
            
        }
        
    }
        else {
            self.fetchcompletebill()
        }
        
        
        
        self.profileimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
         
        
           if let myImage = UIImage(named: "user") {
                  let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                 self.profileimage.image = tintableImage
              }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func fetchcompletebill()
    {
        
        print("Bill id \(self.passedbillid)")
        
        Dataservices.ds.billsplits.child(self.passedbillid).observeSingleEvent(of: .value) { (snp) in
            if let ghy = snp.value as? Dictionary<String,Any> {
                var category : String = ""
                var comment : String = ""
                var creator : String = ""
                var date : String = ""
                var netamount : Int64 = 0
                var subject : String = ""
                var receipients : [billshowreceipients] = []
                if let d = ghy["category"] as? String {
                    category = d
                }
                if let d = ghy["comment"] as? String {
                    comment = d
                }
                if let d = ghy["creator"] as? String {
                    creator = d
                }
                if let d = ghy["date"] as? String {
                    date = d
                }
                if let d = ghy["netamount"] as? Int64 {
                    netamount = d
                }
                if let d = ghy["subject"] as? String {
                    subject = d
                }
                if let d = ghy["receipients"] as? Dictionary<String,Any> {
                    for t in d {
                        if let each = t.value as? Dictionary<String,Any> {
                            var amountafterspliting : [Int64] = []
                            var paidadvance : [Int64] = []
                            var paymentleft : [Int64] = []
                            var splitratio : Int = 1
                            var verified : String = ""
                            var username : String = ""
                            var userimage : String = ""
                            var userid : String = ""
                            if let d = each["amountafterspliting"] as? [Dictionary<String,Any>] {
                                for ea in d {
                                    if let t = ea as? Dictionary<String,Any> {
                                        for eac in t {
                                            if let kk = eac.value as? Int64 {
                                                amountafterspliting.append(kk)
                                            }
                                        }
                                    }
                                }
                            }
                            if let d = each["paidadvance"] as? [Dictionary<String,Any>] {
                                for ea in d {
                                    if let t = ea as? Dictionary<String,Any> {
                                        for eac in t {
                                            if let kk = eac.value as? Int64 {
                                                paidadvance.append(kk)
                                            }
                                        }
                                    }
                                }
                            }
                            if let d = each["paymentleft"] as? [Dictionary<String,Any>] {
                                for ea in d {
                                    if let t = ea as? Dictionary<String,Any> {
                                        for eac in t {
                                            if let kk = eac.value as? Int64 {
                                                paymentleft.append(kk)
                                            }
                                        }
                                    }
                                }
                            }
                            if let d = each["splitratio"] as? Int {
                                splitratio = d
                            }
                            if let d = each["verified"] as? String {
                                verified = d
                            }
                            
                            var newrec = billshowreceipients(amountafterspliting: amountafterspliting, paidadvance: paidadvance, paymentleft: paymentleft, splitratio: splitratio, verified: verified, username: "", userimage: "", userid: t.key)
                            
                            receipients.append(newrec)
                            
                            var billrecord = billshow(category: category, comment: comment, creatorid: creator, date: date, netamount: netamount, subject: subject, receipients: receipients , timestamp : Int64(0 as? Int64 ?? 0) ?? 0 , billid : self.passedbillid)
                            
                            self.passedbill = billrecord
                            self.getinitial(id: self.passedbill?.creatorid ?? "") { (a, b, c) in
                                self.passedbill?.creatorname = b
                                self.passedbill?.creatorimagelink = c
                                self.billcreator.text = b.capitalized
                                self.billcreatedon.text = self.presentdatebetter(x : self.passedbill?.date ?? "")
                                self.billamount.text = "Rs \(self.passedbill?.netamount ?? 0)"
                                self.billsubject.text = "Subject : \(self.passedbill?.subject.capitalized ?? "")"
                                //            self.collection.reloadData()
                                if var allusers = self.passedbill?.receipients as? [billshowreceipients] {
                                    var tmp = 0
                                    for each in 0 ..< allusers.count {
                                        var tmpp = ""
                                        if allusers[each].userid == "TzWWUWB6iFXBx2aXlx1FitcheYh2" {
                                            tmpp = "xytsha3527383"
                                        }
                                        else {
                                            tmpp = allusers[each].userid
                                        }
                                        self.getinitial(id: tmpp) { (a, b, c) in
                                            
                                            self.passedbill?.receipients[each].username = b
                                            self.passedbill?.receipients[each].userimage = c
                                            tmp = tmp + 1
                                            if tmp == allusers.count {
                                                self.collection.reloadData()
                                                print("Here is all receipients")
                                                print(self.passedbill?.receipients)
                                                
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
           self.view.layer.insertSublayer(tracklayer, at: 10)
           
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
           self.view.layer.insertSublayer(shapelayer, at: 10)
           
           let basicanimation = CABasicAnimation(keyPath: "strokeEnd")
           basicanimation.duration = 2
           
           basicanimation.toValue = 1
           basicanimation.repeatCount = Float.infinity
           shapelayer.add(basicanimation, forKey: "hello")
           
           
           
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
        
        var alltmpusers : [billshowreceipients] = []
        
        for each in self.billingamountbefore {
            var m : [Dictionary<String,Any>] = []
            var n : [Dictionary<String,Any>] = []
            var o : [Dictionary<String,Any>] = []
            var mm : [Int64] = []
            var nn : [Int64] = []
            var oo : [Int64] = []
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
            mm.append(Int64(aa))
            nn.append(Int64(bb))
            oo.append(Int64(cc))
            
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
            
            var tmpuser = billshowreceipients(amountafterspliting: mm, paidadvance: nn, paymentleft: oo, splitratio: splitratio, verified: "\(cv)", username: "", userimage: "", userid: each.key)
            alltmpusers.append(tmpuser)
        }
        
        
        var x : Dictionary<String,Any> = ["category" : "billsplit","comment" : "\(comm)","creator" : "\(userid)" ,"date" : "\(d)","netamount" : am , "subject" : "\(comm)" , "receipients" : userdictionary ]
        
       
        
        Dataservices.ds.billsplits.childByAutoId().setValue(x) { (err, ref) in
            if err == nil {
                
                
                
                
                self.passedbill = billshow(category: "billsplit", comment: comm, creatorid: userid, creatorname: "", creatorimagelink: "", date: "\(d)", netamount: Int64(am), subject: comm, receipients: alltmpusers, timestamp: 0, billid: ref.key)
                self.tracklayer.removeAllAnimations()
                self.shapelayer.removeAllAnimations()
                self.tracklayer.isHidden = true
                self.shapelayer.isHidden = true
                self.collection.isHidden = false
                self.billcreatedbylabel.text = "Bill Splitted !"
                self.billcreator.text = "\(comm.capitalized)"
                self.billcreatedon.text = "\(d)"
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
            
           
            var recents : Dictionary<String,Any> = ["lastused" : FIRServerValue.timestamp(),"name" :"\(username)","profileimage" : "\(userimage)","type" : "billsplit"]
            
            for each in self.billingamountbefore {
                var matter = ""
                if let tty = self.billingamountlefttopay[each.key] as? Int {
                    if tty > 0 {
                        matter = "Amount you pay Rs \(tty)"
                    }
                    else {
                        matter = "Amount you get Rs \(tty * -1)"
                    }
                }
                
                var datatoput  : Dictionary<String,Any> = ["category" : "billsplit" , "content" : "You have been added into a billsplit by \(username.capitalized)" , "date" : FIRServerValue.timestamp(), "from" : "\(userid)","matter" : matter,"needapproval" : true , "receipientresponded" : false,"referenceid" : "\(y)" , "status" : "yes","type": "approval"]
                           
                
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
                                                        
                                                        self.billcreator.text = self.passedbill?.creatorname.capitalized ?? ""
                                                        self.billcreatedon.text = self.presentdatebetter(x : self.passedbill?.date ?? "")
                                                        self.billamount.text = "Rs \(self.passedbill?.netamount ?? 0)"
                                                        self.billsubject.text = "Subject : \(self.passedbill?.subject.capitalized ?? "")"
                                                        self.collection.reloadData()
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

    
    
    
    
    
    
    
    func presentdatebetter(x : String) -> String {
        var months = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        var b = x.components(separatedBy: "+")[0]
        var bb = b.components(separatedBy: " ")[0]
        var vvv = b.components(separatedBy: " ")[1]
        var y = bb.components(separatedBy: "-")[0]
        var m = Int(bb.components(separatedBy: "-")[1]) ?? 0
        var d = bb.components(separatedBy: "-")[2]
        var h = vvv.components(separatedBy: ":")[0]
        var min = vvv.components(separatedBy: ":")[1]
        return "\(months[m]) \(d) ,\(y)   \(h):\(min)"
    }
    
    
    func getinitial(id : String , completionHandler: @escaping (_ id:String , _ name : String, _ profileimage : String) -> Void)
    {
        print("Currently trying to fetch data whose creatorname is \(passedbill?.creatorname) and id \(id)")
      
            print("Lets go")
            Dataservices.ds.users.child(id).child("basic").observeSingleEvent(of: .value) { (snap) in
                print(snap)
                if let ss = snap.value as? Dictionary<String,Any> {
                    var name = ""
                    var profileimage = ""
                    if let c = ss["name"] as? String {
                        name = c
                    }
                    if let c = ss["profileimage"] as? String {
                        profileimage = c
                    }
                    print("Got name \(name)")
                    completionHandler(id,name,profileimage)
                }
                else {
                    var uid = KeychainWrapper.standard.string(forKey: "auth")!
                    uid = "xytsha3527383"
                    
                    Dataservices.ds.users.child(uid).child("guestusers").child(id).observeSingleEvent(of: .value) { (guestsnap) in
                        if let guest = guestsnap.value as? Dictionary<String,Any> {
                            completionHandler(id,guest["name"] as! String , "")
                        }
                    }
                }
            }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.passedbill?.receipients.count ?? 0
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eachbillcell", for: indexPath) as? ShowIndividualBillCollectionViewCell {
            var uname = ""
            print("uname compl \(self.passedbill?.receipients[indexPath.row])")
            print("uname \(self.allusersforbill)")
            
            for each in self.allusersforbill {
                print("uname each id \(each.id) and \(self.passedbill?.receipients[indexPath.row].userid)")
            
                if each.id == self.passedbill?.receipients[indexPath.row].userid {
                    uname = each.name
                    print("Uname is \(uname)")
                    break
                }
            }
            if self.passedbill?.receipients[indexPath.row].username == "" || self.passedbill?.receipients[indexPath.row].username == " " {
                self.passedbill?.receipients[indexPath.row].username = uname
            }
            cell.update(x: self.passedbill?.receipients[indexPath.row] ?? billshowreceipients(amountafterspliting: [0], paidadvance: [0], paymentleft: [0], splitratio: 1, verified: "", username: uname, userimage: "", userid: ""))
            return cell
        }
        return UICollectionViewCell()
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.7, height: self.collection.frame.size.height)
    }
    
    
    
    @IBAction func backtapped(_ sender: Any) {
        if self.comingrightaftercreating {
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
//            self.performSegue(withIdentifier: "backhome", sender: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
