//
//  ShowallmybillsViewController.swift
//  Expenseapp
//
//  Created by admin on 12/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ShowallmybillsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    
    @IBOutlet weak var upperview: UIView!
    
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    @IBOutlet weak var mybillsheading: UILabel!
    
    
    @IBOutlet weak var addnewbtn: UIButton!
    
    @IBOutlet weak var bottomview: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var filterbillsbtn: UIButton!
    
    
    @IBOutlet weak var filterview: UIView!
    
    
    @IBOutlet weak var filterbillslabel: UILabel!
    
    @IBOutlet weak var closebtn: UIButton!
    
    
    @IBOutlet weak var billcreaterbylabel: UILabel!
    
    @IBOutlet weak var startdatelabel: UILabel!
    
    
    @IBOutlet weak var Enddatelabel: UILabel!
    
    
    @IBOutlet weak var startdateselected: UILabel!
    
    @IBOutlet weak var enddateselected: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var startdatepicker: UIDatePicker!
    
    
    @IBOutlet weak var enddatepicker: UIDatePicker!
    
    
    @IBOutlet weak var resetbtn: UIButton!
    
    @IBOutlet weak var startpickerheight: NSLayoutConstraint!
    
    @IBOutlet weak var endpickerheight: NSLayoutConstraint!
    
    
    var allmybills : [billshow] = []
    var filteredmybills : [billshow] = []
    var lastfetcheddata = ""
    var lastfetcchedtimestamp : Int64 = 0
    var filteredlastfetcheddata = ""
    var filteredlastfetcchedtimestamp : Int64 = 0
    var templock = true
    var canfetchmore = true
    var filtercanfetchmore = true
    
    var isinfiltermode = false
    
    var ownedby = "all"
    var startdata : Date? = nil
    var enddate : Date? = nil
    
    var passedbill : billshow?
    
    @IBOutlet weak var applybtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolors()
        var ht = (self.view.frame.size.height - 500)/2
        self.startpickerheight.constant = ht
        self.endpickerheight.constant = ht
        self.segment.isHidden = true
        self.billcreaterbylabel.isHidden = true
        
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.backbtn.setImage(tintableImage, for: .normal)
        }
        table.delegate = self
        table.dataSource = self
        fetchdata()

        // Do any additional setup after loading the view.
    }
    
    
    func setupcolors()
    {
        
        
        self.upperview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.filterview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
          
            
        self.mybillsheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            
        self.addnewbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.filterbillsbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.filterbillsbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.closebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.filterbillslabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.billcreaterbylabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.startdatelabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.Enddatelabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.startdateselected.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.enddateselected.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            
            self.resetbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
           self.resetbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
         self.applybtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.applybtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        startdatepicker.setValue(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
        startdatepicker.setValue(false, forKey: "highlightsToday")

        enddatepicker.setValue(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
        enddatepicker.setValue(false, forKey: "highlightsToday")
        
        self.segment.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.segment.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                      
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
        let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()) ]
                       segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
                      segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        self.resetbtn.layer.cornerRadius = self.resetbtn.frame.size.height/2
        self.applybtn.layer.cornerRadius = self.applybtn.frame.size.height/2
            
    
        
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
    
    
    
    func fetchfiltereddata(lastused : Int64)
    {
        print("Filter Master")
        var temp = 0
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        if lastused == 0 {
            if let s = startdata , let e = enddate {
                
                var start = (self.startdata?.timeIntervalSince1970 ?? 0) * 1000
                var end = (self.enddate?.timeIntervalSince1970 ?? 0 ) * 1000
                var tt = FIRServerValue.timestamp() as! [String:Any]
                var current =  NSDate(timeIntervalSince1970: (tt as? Double ?? 0) / 1000)
                var today = Date().timeIntervalSince1970
                
                print("Start \(start) , End \(end) , current \(current) , today \(today)")
                
                Dataservices.ds.users.child(userid).child("billsplits").queryOrderedByValue().queryStarting(atValue: start).queryEnding(atValue: end).queryLimited(toLast: 5).observeSingleEvent(of: .value) { (snappy) in
                    print(snappy)
                    if let ss = snappy.value as? Dictionary<String,Any> {
                        for sss in ss {
                            Dataservices.ds.billsplits.child(sss.key).observeSingleEvent(of: .value) { (snp) in
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
                                                
                                                
                                                    
                                                
                                                
                                                
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                    print("Hurrah \(sss.value)")
                                    
                                    var billrecord = billshow(category: category, comment: comment, creatorid: creator, date: date, netamount: netamount, subject: subject, receipients: receipients , timestamp : Int64(sss.value as? Int64 ?? 0) ?? 0 , billid : sss.key)
                                    
                                    self.filteredmybills.append(billrecord)
                                    temp = temp + 1
                                    if snappy.childrenCount == temp {
                                        self.filteredmybills.sort { (a, b) -> Bool in
                                            print("Comparing \(a.timestamp) and \(b.timestamp)")
                                            return a.timestamp > b.timestamp
                                        }
                                        self.filteredlastfetcheddata = self.filteredmybills.last?.billid as! String
                                        self.filteredlastfetcchedtimestamp = self.filteredmybills.last?.timestamp ?? 0
                                        self.table.reloadData()
                                        print("should end at \(self.filteredlastfetcheddata)")
                                        for each in self.filteredmybills {
                                            print("got \(each.billid) \(each.timestamp)")
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
    
    
    
    
    
    func filteredfetchpagingdata()
    {
        print("Filter Pagination \(self.filteredlastfetcchedtimestamp)")
        var temp = 0
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        
        if let s = startdata , let e = enddate {
            var start = (self.startdata?.timeIntervalSince1970 ?? 0) * 1000
            var end = (self.enddate?.timeIntervalSince1970 ?? 0 ) * 1000
            var tempdrray : [billshow] = []
            Dataservices.ds.users.child(userid).child("billsplits").queryOrderedByValue().queryStarting(atValue: start).queryEnding(atValue: end , childKey: self.filteredlastfetcheddata).queryLimited(toLast: 5).observeSingleEvent(of: .value) { (snappy) in
                if let ss = snappy.value as? Dictionary<String,Any>{
                    print("Key is \(ss)")
                    if snappy.childrenCount <= 1 {
                        self.filtercanfetchmore = false
                    }
                    for sss in ss {
                        print(sss)
                        print(sss.key)
                        Dataservices.ds.billsplits.child(sss.key).observeSingleEvent(of: .value) { (snp) in
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
                                            
                                            
                                                
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                                var billrecord = billshow(category: category, comment: comment, creatorid: creator, date: date, netamount: netamount, subject: subject, receipients: receipients , timestamp : Int64(sss.value as? Int64 ?? 0) ?? 0, billid: sss.key)
                                tempdrray.append(billrecord)
                                temp = temp + 1
                                if snappy.childrenCount == temp {
                                    tempdrray.sort { (a, b) -> Bool in
                                        a.timestamp > b.timestamp
                                    }
                                    self.filteredlastfetcheddata = tempdrray.last?.billid as! String
                                    self.filteredlastfetcchedtimestamp = tempdrray.last?.timestamp ?? 0
                                    for k in 0 ..< self.filteredmybills.count {
                                        for m in 0 ..< tempdrray.count {
                                            if k < self.filteredmybills.count && m < tempdrray.count {
                                                if self.filteredmybills[k].billid == tempdrray[m].billid {
                                                    tempdrray.remove(at: m)
                                                }
                                            }
                                        }
                                    }
                                    if tempdrray.count == 0 {
                                        self.filtercanfetchmore = false
                                    }
                                    self.filteredmybills = self.filteredmybills + tempdrray
                                    
                                    self.table.reloadData()
                                    print("--------------\(self.filteredlastfetcheddata)------------------")
                                    for each in tempdrray {
                                        print("got \(each.billid)  \(each.timestamp)")
                                    }
                                }
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    func fetchdata()
    {
        var temp = 0
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        Dataservices.ds.users.child(userid).child("billsplits").queryOrderedByValue().queryLimited(toLast: 5).observeSingleEvent(of: .value) { (snappy) in
            if let ss = snappy.value as? Dictionary<String,Any>{
                print("Key is \(ss)")
                for sss in ss {
                    print(sss)
                    print(sss.key)
                    Dataservices.ds.billsplits.child(sss.key).observeSingleEvent(of: .value) { (snp) in
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
                                        
                                        
                                            
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            print("Hurrah \(sss.value)")
                            
                            var billrecord = billshow(category: category, comment: comment, creatorid: creator, date: date, netamount: netamount, subject: subject, receipients: receipients , timestamp : Int64(sss.value as? Int64 ?? 0) ?? 0 , billid : sss.key)
                            
                            self.allmybills.append(billrecord)
                            temp = temp + 1
                            if snappy.childrenCount == temp {
                                self.allmybills.sort { (a, b) -> Bool in
                                    print("Comparing \(a.timestamp) and \(b.timestamp)")
                                    return a.timestamp > b.timestamp
                                }
                                self.lastfetcheddata = self.allmybills.last?.billid as! String
                                self.lastfetcchedtimestamp = self.allmybills.last?.timestamp ?? 0
                                self.table.reloadData()
                                print("should end at \(self.lastfetcheddata)")
                                for each in self.allmybills {
                                    print("got \(each.billid) \(each.timestamp)")
                                }
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    func fetchpagingdata()
    {
        print("Givinh shot with \(canfetchmore)")
        var temp = 0
        var userid = KeychainWrapper.standard.string(forKey: "auth") as! String
        userid = "xytsha3527383"
        print("should end at \(self.lastfetcheddata)")
        var tempdrray : [billshow] = []
        Dataservices.ds.users.child(userid).child("billsplits").queryOrderedByValue().queryLimited(toLast: 5).queryEnding(atValue: self.lastfetcchedtimestamp).observeSingleEvent(of: .value) { (snappy) in
            if let ss = snappy.value as? Dictionary<String,Any>{
                print("Key is \(ss)")
                if snappy.childrenCount <= 1 {
                    self.canfetchmore = false
                }
                for sss in ss {
                    print(sss)
                    print(sss.key)
                    Dataservices.ds.billsplits.child(sss.key).observeSingleEvent(of: .value) { (snp) in
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
                                        
                                        
                                            
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            var billrecord = billshow(category: category, comment: comment, creatorid: creator, date: date, netamount: netamount, subject: subject, receipients: receipients , timestamp : Int64(sss.value as? Int64 ?? 0) ?? 0, billid: sss.key)
                            tempdrray.append(billrecord)
                            temp = temp + 1
                            if snappy.childrenCount == temp {
                                tempdrray.sort { (a, b) -> Bool in
                                    a.timestamp > b.timestamp
                                }
                                self.lastfetcheddata = tempdrray.last?.billid as! String
                                self.lastfetcchedtimestamp = tempdrray.last?.timestamp ?? 0
                                tempdrray.remove(at: tempdrray.count - 1)
                                self.allmybills = self.allmybills + tempdrray
                                
                                self.table.reloadData()
                                print("--------------\(self.lastfetcheddata)------------------")
                                for each in tempdrray {
                                    print("got \(each.billid)  \(each.timestamp)")
                                }
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isinfiltermode {
            return self.filteredmybills.count
        }
        else {
            return self.allmybills.count
        }
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "billcell", for: indexPath) as? ShowMyBillsTableViewCell {
            if isinfiltermode && filteredmybills.count > indexPath.row {
                cell.udpdate(x: self.filteredmybills[indexPath.row])
            }
            else {
                cell.udpdate(x: self.allmybills[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                      return self.view.frame.size.height/4 > 200 ? self.view.frame.size.height/4 : 200
             
          }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.passedbill = allmybills[indexPath.row]
        if let p = self.passedbill {
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "shwindi") as! ShowIndividualBillViewController
                vc.passedbill = self.passedbill
                vc.passbackbill = { a in
                    for each in 0 ..< self.allmybills.count {
                        if self.allmybills[each].billid == a.billid {
                            self.allmybills[each] = a
                        }
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = ShowIndividualBillViewController()
                vc.passedbill = self.passedbill
                vc.passbackbill = { a in
                    for each in 0 ..< self.allmybills.count {
                        if self.allmybills[each].billid == a.billid {
                            self.allmybills[each] = a
                        }
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
//            self.performSegue(withIdentifier: "explainbill", sender: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isinfiltermode {
            if templock == false && self.filtercanfetchmore == true {
                if filteredmybills.count > 0 {
                    self.filteredlastfetcchedtimestamp = filteredmybills.last?.timestamp ?? 0
                    self.filteredlastfetcheddata = filteredmybills.last?.billid ?? ""
                    self.filteredfetchpagingdata()
                    templock = true

                }
            }
            if indexPath.row == self.filteredmybills.count - 2 {
                templock = false
            }
        }
        else
        {
            if templock == false && self.canfetchmore == true {
                self.fetchpagingdata()
                templock = true
            }
            if indexPath.row == self.allmybills.count - 2 {
                templock = false
            }
        }
        
    }
    
    @IBAction func resetbtnpressed(_ sender: Any) {
        self.startdata = nil
        self.enddate = nil
        self.startdateselected.text = "None"
        self.enddateselected.text = "None"
        self.isinfiltermode = false
        self.table.reloadData()
        self.filterview.isHidden = true
    }
    
    
    @IBAction func applybtnpressed(_ sender: Any) {
        var x = ""
        var y = ""
        self.startdata = self.startdatepicker.date
        self.enddate = self.enddatepicker.date
        if let s = self.startdata {
            let dd = DateFormatter()
            dd.dateFormat = "dd/MM/yy hh:mm"
             x = dd.string(from: s)
        }
        if let s = self.enddate {
            let dd = DateFormatter()
            dd.dateFormat = "dd/MM/yy hh:mm"
             y = dd.string(from: s)
        }
        self.startdateselected.text = "\(x)"
        self.enddateselected.text = "\(y)"
        self.isinfiltermode = true
         filteredmybills  = []
        var start = Int64((self.startdata?.timeIntervalSince1970 ?? 0) * 1000)
        var end = Int64((self.enddate?.timeIntervalSince1970 ?? 0 ) * 1000)
        for each in self.allmybills {
            if each.timestamp >= start && each.timestamp <= end {
                filteredmybills.append(each)
            }
        }

       
        
        if filteredmybills.count == 0 {
            self.table.reloadData()
            self.fetchfiltereddata(lastused: 0)
        }
        else if filteredmybills.count < 5 {
            self.table.reloadData()
            if self.filtercanfetchmore {
                self.filteredlastfetcchedtimestamp = filteredmybills.last?.timestamp ?? 0
                self.filteredlastfetcheddata = filteredmybills.last?.billid ?? ""
                print("Check this lastdata \(filteredlastfetcheddata)")
                self.fetchpagingdata()
            }
        }
        else {
            self.filteredlastfetcchedtimestamp = filteredmybills.last?.timestamp ?? 0
            self.filteredlastfetcheddata = filteredmybills.last?.billid ?? ""
            self.table.reloadData()
        }
        
        self.filterview.isHidden = true
    }
    
    @IBAction func closefilterviewpressed(_ sender: Any) {
        self.filterview.isHidden = true
    }
    
    @IBAction func presentfilterviewpressed(_ sender: Any) {
        self.filterview.isHidden = false
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addnewbtnpressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "addnewbill") as! ChooseSplitoptionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = ChooseSplitoptionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ShowIndividualBillViewController {
            seg.passedbill = self.passedbill
            seg.passbackbill = { a in
                for each in 0 ..< self.allmybills.count {
                    if self.allmybills[each].billid == a.billid {
                        self.allmybills[each] = a
                    }
                }
            }
        }
        
    }
    
    
    
}
