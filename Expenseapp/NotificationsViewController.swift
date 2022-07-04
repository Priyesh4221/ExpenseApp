//
//  NotificationsViewController.swift
//  Expenseapp
//
//  Created by admin on 11/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper





class NotificationsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    
    var allnotifiations : [notification] = []
    
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var bottomview: UIView!
    
    @IBOutlet weak var notificationlabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    var selectednotification : notification?
    
    var lastnotificationobtained = ""
    var canfetchmore = true
    var templock = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.table.delegate = self
        self.table.dataSource = self
        setupcolors()
        fetchdata()
        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.backbtn.setImage(tintableImage, for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchdata()
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        Dataservices.ds.users.child(userid).child("notifications").queryOrdered(byChild: "date").queryLimited(toLast: 10).observeSingleEvent(of: .value) { (snap) in
            if let ss = snap.value as? Dictionary<String,Any> {
                for each in ss {
                    if let data = each.value as? Dictionary<String,Any> {
                        var cat = ""
                        var tit = ""
                        var mat = ""
                        var dt : Int64 = 0
                        var frm = ""
                        var needapp = false
                        var responded = false
                        var refid = ""
                        var type = ""
                        var status = ""
                        
                        if let e = data["category"] as? String {
                            cat = e
                        }
                        if let e = data["content"] as? String {
                            tit = e
                        }
                        if let e = data["date"] as? Int64 {
                            dt = e
                        }
                        if let e = data["from"] as? String {
                            frm = e
                        }
                        if let e = data["matter"] as? String {
                            mat = e
                        }
                        if let e = data["needapproval"] as? Bool {
                            needapp = e
                        }
                        if let e = data["receipientresponded"] as? Bool {
                            responded = e
                        }
                        if let e = data["referenceid"] as? String {
                            refid = e
                        }
                        if let e = data["type"] as? String {
                            type = e
                        }
                        if responded == true {
                            if let e = data["status"] as? String {
                                status = e
                            }
                        }
                        
                        var nt = notification(key: each.key, category: cat, title: tit, matter: mat, time: dt, fromuser: frm, needapproval: needapp, receipientresponded: responded, referenceid: refid, type: type , status : status)
                        self.allnotifiations.append(nt)
                    
                }
            }
                self.allnotifiations.sort { (a, b) -> Bool in
                    a.time > b.time
                }
                self.table.reloadData()
        }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var notif = self.allnotifiations[indexPath.row]
        selectednotification = notif
        if notif.category.lowercased() == "billsplit" {
            
            if let s = self.selectednotification?.referenceid as? String {
                if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "shwindi") as! ShowIndividualBillViewController
                vc.passedbillid = s
                vc.passingwihtoutdata = true
                self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                     let vc = ShowIndividualBillViewController()
                    vc.passedbillid = s
                    vc.passingwihtoutdata = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
//            self.performSegue(withIdentifier: "notiftobill", sender: nil)
        }
        else if notif.category.lowercased() == "individual" {
            
            if let s = self.selectednotification?.referenceid as? String {
                if #available(iOS 13.0, *) {
                       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
                       vc.justcontactuserid = s
                       vc.refreshdata = { a in
                           if a {
                               
                           }
                       }
                       self.navigationController?.pushViewController(vc, animated: true)
                   } else {
                       // Fallback on earlier versions
                       let vc = ContactsindividualViewController()
                       vc.justcontactuserid = s
                       vc.refreshdata = { a in
                           if a {
                               
                           }
                       }
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
            }
            
            
//            self.performSegue(withIdentifier: "notiftoindividual", sender: nil)
        }
    }
    
    
    
    
    
    func fetchmoredata()
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        print("Fetching more")
        Dataservices.ds.users.child(userid).child("notifications").queryOrdered(byChild: "date").queryLimited(toLast: 10).queryEnding(atValue: self.allnotifiations.last?.time).observeSingleEvent(of: .value) { (snap) in
            if let ss = snap.value as? Dictionary<String,Any> {
                if ss.count == 2 {
                    self.canfetchmore = false
                }
                else {
                for each in ss {
                    if let data = each.value as? Dictionary<String,Any> {
                        var cat = ""
                        var tit = ""
                        var mat = ""
                        var dt : Int64 = 0
                        var frm = ""
                        var needapp = false
                        var responded = false
                        var refid = ""
                        var type = ""
                        var status = ""
                        
                        if let e = data["category"] as? String {
                            cat = e
                        }
                        if let e = data["content"] as? String {
                            tit = e
                        }
                        if let e = data["date"] as? Int64 {
                            dt = e
                        }
                        if let e = data["from"] as? String {
                            frm = e
                        }
                        if let e = data["matter"] as? String {
                            mat = e
                        }
                        if let e = data["needapproval"] as? Bool {
                            needapp = e
                        }
                        if let e = data["receipientresponded"] as? Bool {
                            responded = e
                        }
                        if let e = data["referenceid"] as? String {
                            refid = e
                        }
                        if let e = data["type"] as? String {
                            type = e
                        }
                        if responded == true {
                            if let e = data["status"] as? String {
                                status = e
                            }
                        }
                        
                        var nt = notification(key: each.key, category: cat, title: tit, matter: mat, time: dt, fromuser: frm, needapproval: needapp, receipientresponded: responded, referenceid: refid, type: type , status : status)
                        print("check \(each.key)")
                        self.allnotifiations.append(nt)
                    
                }
            }
            }
                self.allnotifiations.sort { (a, b) -> Bool in
                    a.time > b.time
                }
                self.table.reloadData()
        }
        }
    }
    
    
    
    
    
    
    
    func setupcolors()
    {
        self.upperview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.notificationlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
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

        @IBAction func backbtntapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.allnotifiations.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "notifcell", for: indexPath) as? NotificationsTableViewCell {
                cell.notificationresponded = {a ,b in
                    var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
                    userid = "xytsha3527383"
                    if a.category.lowercased() == "billsplit" {
                        var status = ""
                        if b {
                            status = "approve"
                        }
                        else {
                            status = "denied"
                        }
                        Dataservices.ds.billsplits.child(a.referenceid).child("receipients").child(userid).child("verified").setValue(status) { (err, ref) in
                            if err == nil {
                            var refresh : Dictionary<String,Any> = ["receipientresponded" : true , "status" : status]
                                Dataservices.ds.users.child(userid).child("notifications").child(a.key).updateChildValues(refresh) { (err3, ref3) in
                                if err3 == nil {
                                    if b {
                                        cell.declinebtn.isHidden = true
                                        cell.acceptbtn.setTitle("Approved", for: .normal)
                                        cell.acceptbtn.isEnabled = false
                                        cell.declinebtn.isEnabled = false
                                    }
                                    else {
                                        cell.acceptbtn.isHidden = true
                                        cell.declinebtn.setTitle("Rejected", for: .normal)
                                        cell.acceptbtn.isEnabled = false
                                        cell.declinebtn.isEnabled = false
                                    }
                                }
                            }
                        }
                            
                        }
                    }
                    else if a.category.lowercased() == "individual" {
                        var status = ""
                        if b {
                            status = "approve"
                        }
                        else {
                            status = "denied"
                        }
                        Dataservices.ds.transactions.child(a.referenceid).child("verified").setValue(status) { (errin, refin) in
                            if errin == nil {
                                var refresh : Dictionary<String,Any> = ["receipientresponded" : true , "status" : status]
                                    Dataservices.ds.users.child(userid).child("notifications").child(a.key).updateChildValues(refresh) { (err3, ref3) in
                                    if err3 == nil {
                                        if b {
                                            cell.declinebtn.isHidden = true
                                            cell.acceptbtn.setTitle("Approved", for: .normal)
                                            cell.acceptbtn.isEnabled = false
                                            cell.declinebtn.isEnabled = false
                                        }
                                        else {
                                            cell.acceptbtn.isHidden = true
                                            cell.declinebtn.setTitle("Rejected", for: .normal)
                                            cell.acceptbtn.isEnabled = false
                                            cell.declinebtn.isEnabled = false
                                        }
                                    }
                                }

                            }
                        }
                        
                    }
                }
                
                
                cell.update(n : self.allnotifiations[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let notif = self.allnotifiations[indexPath.row]
        var count = notif.matter.count
        var ht = CGFloat(count / 40)
        return (250.0 + (ht * 30.0))
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         print("Check \(indexPath.row) out of \(self.allnotifiations.count) with temp \(templock) and canfetchmore \(canfetchmore)")
               if indexPath.row == self.allnotifiations.count - 3 && templock == false && canfetchmore == true {
                   templock = true
                   self.fetchmoredata()
               }
               
               if indexPath.row == self.allnotifiations.count - 1 {
                   templock = false
               }
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ContactsindividualViewController {
            if let s = self.selectednotification {
                seg.justcontactuserid = s.referenceid
            }
            seg.refreshdata = { a in
                if a {
                    
                }
            }
            
        }
        if let seg = segue.destination as? ShowIndividualBillViewController {
            if let s = self.selectednotification?.referenceid as? String {
                seg.passedbillid = s
                seg.passingwihtoutdata = true
            }
            
            
        }
    }
    
   
        
        

}
