//
//  OfficeSalesViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 5/6/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class OfficeSalesViewController: UIViewController {

    
    var expensetype = "officeexpenses"
    
    @IBOutlet weak var footerview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var individualamount: UILabel!
    
    @IBOutlet weak var footerestview: UIView!
    
    @IBOutlet weak var backgroundoverlay: UIView!
    
    @IBOutlet weak var backgroundimage: UIImageView!
    
    
    @IBOutlet weak var header: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var amount: UILabel!
    
    
    @IBOutlet weak var span: UILabel!
    
    @IBOutlet weak var prevbtn: Custombtn!
    
    
    @IBOutlet weak var nextbtn: Custombtn!
    
    @IBOutlet weak var choosecustomdatebtn: Custombtn!
    
    @IBOutlet weak var addsalespurchasebtn: Custombtn!
    
    
    
    @IBOutlet weak var overfilterview: UIView!
    
    @IBOutlet weak var filterviewbackbtn: UIButton!
    
    
    @IBOutlet weak var addsaleslabel: UILabel!
    
    
    @IBOutlet weak var salespurchasesegment: UISegmentedControl!
    
    
    
    @IBOutlet weak var enteramountlabel: UILabel!
    
    
    @IBOutlet weak var plusminuslabel: UILabel!
    
    
    @IBOutlet weak var amounttextfield: UITextField!
    
    
    
    @IBOutlet weak var subjectlabel: UILabel!
    
    @IBOutlet weak var subjectfield: UITextField!
    
    
    
    @IBOutlet weak var salespurchaseaddbtn: UIButton!
    
    
    @IBOutlet weak var amountcover: UIView!
    
    @IBOutlet weak var startdatelabel: UILabel!
    
    
    @IBOutlet weak var startdatepicker: UIDatePicker!
    
    
    @IBOutlet weak var endatelabel: UILabel!
    
    
    @IBOutlet weak var enddatepicker: UIDatePicker!
    
    
    @IBOutlet weak var adddatebtn: UIButton!
    
    @IBOutlet weak var startdateupperspace: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var startpickerheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var endpickerheight: NSLayoutConstraint!
    
    
    var datas : Dictionary<String,Dictionary<String,Int>> = [:]
    
    
    
    @IBOutlet weak var viewallsalespurchases: UIButton!
    
    
    
    
    
    var officeroomid = "officeroomid"
    var officeroomname = ""
    var currentstartdate : Date?
    var currentenddate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolors()
        self.fetchdata(sd: Date(), ed: Date())
        var d = Date()
        currentstartdate = d
        currentenddate = d
        self.fetchjusttotal(sd: d, ed:d)
        
        var y = self.startdatelabel.frame.origin.y
        self.startdateupperspace.constant = (-1 * y) + 128
        self.startpickerheight.constant = self.view.frame.size.height / 4
        self.endpickerheight.constant = self.view.frame.size.height / 4
        
        
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
               if let myImage = UIImage(named: "backpdf") {
                          let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                          self.backbtn.setImage(tintableImage, for: .normal)
                      }
        
        self.filterviewbackbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               if let myImage = UIImage(named: "backpdf") {
                          let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                          self.filterviewbackbtn.setImage(tintableImage, for: .normal)
                      }
        
        self.overfilterview.isHidden = true
        
        Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("roomname").observeSingleEvent(of: .value) { (name) in
            if let oname = name.value as? String {
                self.header.text = oname.capitalized
                self.officeroomname = oname
            }
        }
        
        if self.expensetype == "houseexpenses" {
            self.addsalespurchasebtn.setTitle("Add Expense", for: .normal)
            self.addsaleslabel.text = "Add Expense"
            self.salespurchasesegment.isHidden = true
            self.viewallsalespurchases.setTitle("View All Expenses", for: .normal)
            
        }
        
        
        // Do any additional setup after loading the view.
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
        tracklayer.strokeColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
           tracklayer.lineWidth = 6
           self.view.layer.insertSublayer(tracklayer, at: 10)
           
           shapelayer.path = circularpath.cgPath
           shapelayer.fillColor = UIColor.clear.cgColor
           
           shapelayer.strokeEnd = 0
           shapelayer.lineCap = kCALineCapRound
           shapelayer.strokeColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
           shapelayer.lineWidth = 6
           shapelayer.opacity = 0.8
           shapelayer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
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
       
    
    func setupcolors()
    {
        let x = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        var r : CGFloat = 0.0
        var g : CGFloat = 0.0
        var b : CGFloat = 0.0
        var a : CGFloat = 0.0
        x.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.footerview.backgroundColor =  UIColor(red: r, green: g, blue: b, alpha: 0.8)
        
        self.backbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        let y = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        var rr : CGFloat = 0.0
        var gg : CGFloat = 0.0
        var bb : CGFloat = 0.0
        var aa : CGFloat = 0.0
        y.getRed(&rr, green: &gg, blue: &bb, alpha: &aa)
        self.backgroundoverlay.backgroundColor = UIColor(red: rr, green: gg, blue: bb, alpha: 0.95)
        
        self.header.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.amount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.individualamount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.span.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.prevbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.nextbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.choosecustomdatebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.addsalespurchasebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        
        
        self.viewallsalespurchases.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
        self.prevbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.nextbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.choosecustomdatebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.addsalespurchasebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.segment.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.segment.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
                      
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
        let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()) ]
                       segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
                      segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
                     
  
        self.footerestview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        
        
        self.overfilterview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.addsaleslabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.enteramountlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.plusminuslabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.amounttextfield.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.subjectfield.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.subjectlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.startdatelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            self.endatelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amounttextfield.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.amounttextfield.layer.borderWidth = 2
        self.amounttextfield.layer.cornerRadius = self.amounttextfield.frame.size.height/2
        self.amounttextfield.backgroundColor = UIColor.clear
        self.subjectfield.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.subjectfield.layer.borderWidth = 2
        self.subjectfield.layer.cornerRadius = self.subjectfield.frame.size.height/2
        self.subjectfield.backgroundColor = UIColor.clear
        self.salespurchaseaddbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.salespurchaseaddbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.salespurchaseaddbtn.layer.cornerRadius = self.salespurchaseaddbtn.frame.size.height/2
        
        self.adddatebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.adddatebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.adddatebtn.layer.cornerRadius = self.adddatebtn.frame.size.height/2
        
        self.salespurchasesegment.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.salespurchasesegment.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        let titleTextAttributes3 = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
        let titleTextAttributes4 = [NSAttributedStringKey.foregroundColor: Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()) ]
         salespurchasesegment.setTitleTextAttributes(titleTextAttributes3, for: .normal)
        salespurchasesegment.setTitleTextAttributes(titleTextAttributes4, for: .selected)
        
        startdatepicker.setValue(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
               startdatepicker.setValue(false, forKey: "highlightsToday")

        enddatepicker.setValue(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
               enddatepicker.setValue(false, forKey: "highlightsToday")
        
        
        
    }
    
    func hideupper()
    {
        self.addsaleslabel.isHidden = true
        self.salespurchasesegment.isHidden = true
        self.amountcover.isHidden = true
        self.enteramountlabel.isHidden = true
          self.subjectlabel.isHidden = true
          self.subjectfield.isHidden = true
        self.salespurchaseaddbtn.isHidden = true
        
        self.startdatelabel.isHidden = false
        self.startdatepicker.isHidden = false
        self.endatelabel.isHidden = false
        self.enddatepicker.isHidden = false
        self.adddatebtn.isHidden = false
    }
    
    
    func hidelower()
    {
        self.addsaleslabel.isHidden = false
        self.salespurchasesegment.isHidden = false
        self.amountcover.isHidden = false
        self.enteramountlabel.isHidden = false
          self.subjectlabel.isHidden = false
          self.subjectfield.isHidden = false
        self.salespurchaseaddbtn.isHidden = false
        
        self.startdatelabel.isHidden = true
        self.startdatepicker.isHidden = true
        self.endatelabel.isHidden = true
        self.enddatepicker.isHidden = true
        self.adddatebtn.isHidden = true
    }
    
    func fetchjusttotal(sd : Date , ed : Date)
    {
        var singleday = true
        if sd.timeIntervalSince1970 == ed.timeIntervalSince1970 {
            singleday = true
        }
        else {
            singleday = false
        }
        let calendar = Calendar.current
        let yx = calendar.component(.year, from: sd)
        let mx = calendar.component(.month, from: sd)
        let dx = calendar.component(.day, from: sd)
        
        let yyx = calendar.component(.year, from: ed)
        let mmx = calendar.component(.month, from: ed)
        let ddx = calendar.component(.day, from: ed)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        var totalcount = 0
        var sales = 0
        var purchase = 0
        if let startdate = dateFormatter.date(from: "\(yx)-\(mx)-\(dx) 00:00:01 +0000" ?? "") as? Date {
            if let enddate = dateFormatter.date(from: "\(yyx)-\(mmx)-\(ddx) 23:59:59 +0000" ?? "") as? Date {
                var ssd = startdate
                var eed = enddate
                print("Start date is \(ssd)")
                print("End date is \(eed)")
                var stp = (Int64(ssd.timeIntervalSince1970 *  1000))
                var etp = (Int64(eed.timeIntervalSince1970 * 1000))
                print(stp)
                print(etp)
                var found = false
                if let fs = self.datas["\(stp)"] as? Dictionary<String,Int64> {
                    if let ss = fs["\(etp)"] as? Int {
                        found = true
                        print("Need not data")
                        self.updateui(x : ss , sd : stp , ed : etp , singleday : singleday)
                    }
                }
                if found == false {
                    print("Need Data")
                    self.shapelayer.isHidden = false
                    self.tracklayer.isHidden = false
                    self.startloader()
                    self.individualamount.text = ""
                    Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("totalcount").queryOrderedByValue().queryStarting(atValue: stp).queryEnding(atValue: etp).observeSingleEvent(of: .value) { (snap) in
                        if let ss = snap.value as? Dictionary<String,Any> {
                            print("Snapshit is")
                            print(ss)
                            for each in ss {
                                print("Each is ")
                                print(each)
                                if let e = Int(each.key) as? Int {
                                    print(e)
                                    totalcount = totalcount + e
                                    if e > 0 {
                                        sales = sales + e
                                    }
                                    else {
                                        purchase = purchase + e
                                    }
                                }
                            }
//                            self.datas["\(stp)"] = ["\(etp)" : totalcount]
                            print("Need \(self.datas)")
                            if self.expensetype == "officeexpenses" {
                                self.individualamount.text = "Sales : \(sales) | Purchase : \(purchase * -1)"
                            }
                            else {
                                self.individualamount.text = "Expenses : \(sales) "
                            }
                            self.updateui(x : totalcount , sd : stp , ed : etp , singleday : singleday)
                            self.shapelayer.isHidden = true
                            self.tracklayer.isHidden = true
                        }
                        else {
                            self.individualamount.text = ""
                            self.shapelayer.isHidden = true
                            self.tracklayer.isHidden = true
                            self.updateui(x : totalcount , sd : stp , ed : etp , singleday : singleday)
                        }
                    }
                }

                
            }
        }
        
    }
    
    
    func updateui(x : Int , sd : Int64 , ed : Int64 , singleday : Bool)
    {
        if singleday {
            self.span.text = "Showing for \(convertTimestamp(serverTimestamp: sd))"
        }
        else {
            self.span.text = "Showing from \(convertTimestamp(serverTimestamp: sd)) to \(convertTimestamp(serverTimestamp: ed))"
        }
        self.amount.text = "Rs \(x)"
    }
    
    
    let monthsname = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        
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
            
            formatter.dateFormat = "dd/MM/yyyy"
            let calendar = Calendar.current
            let yx = calendar.component(.year, from: date as Date)
            let mx = monthsname[calendar.component(.month, from: date as Date)]
            let dx = calendar.component(.day, from: date as Date)
            return "\(dx) \(mx) \(yx)"
            
            return formatter.string(from: date as Date)
        }
        return ""
    }
    
    
    func fetchdata(sd : Date , ed : Date)
    {
        let calendar = Calendar.current
        let yx = calendar.component(.year, from: sd)
        let mx = calendar.component(.month, from: sd)
        let dx = calendar.component(.day, from: sd)
        
        let yyx = calendar.component(.year, from: ed)
        let mmx = calendar.component(.month, from: ed)
        let ddx = calendar.component(.day, from: ed)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        if let startdate = dateFormatter.date(from: "\(yx)-\(mx)-\(dx) 00:00:01 +0000" ?? "") as? Date {
            if let enddate = dateFormatter.date(from: "\(yyx)-\(mmx)-\(ddx) 23:59:59 +0000" ?? "") as? Date {
                var ssd = startdate
                var eed = enddate
                print("Start date is \(ssd)")
                print("End date is \(eed)")
                var stp = (Int64(ssd.timeIntervalSince1970 *  1000))
                var etp = (Int64(eed.timeIntervalSince1970 * 1000))
                print(stp)
                print(etp)
                Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("records").queryOrdered(byChild: "createdon").queryStarting(atValue: stp).queryEnding(atValue: etp).observeSingleEvent(of: .value) { (snap) in
                    if let ss = snap.value as? Dictionary<String,Any> {
                        print(ss)
                    }
                }

                
            }
        }
        
    }
    
    
    
    
    func fetchnewdata()
    {
        var d = Date()
        if segment.selectedSegmentIndex == 0 {
            currentstartdate = d
            currentenddate = d
            self.fetchjusttotal(sd: d, ed: d)
        }
        else if segment.selectedSegmentIndex == 1 {
            var nd = d - (7 * 24 * 60 * 60)
            currentstartdate = nd
            currentenddate = d
            self.fetchjusttotal(sd: nd, ed: d)
        }
        else {
            var nd = d - (30 * 24 * 60 * 60)
            currentstartdate = nd
            currentenddate = d
            self.fetchjusttotal(sd: nd, ed: d)
        }
    }
    

    @IBAction func backbtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func segmenttapped(_ sender: Any) {
        fetchnewdata()
    }
    
    
    @IBAction func prevbtntapped(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            currentstartdate = currentstartdate! - (24 * 60 * 60)
            currentenddate = currentenddate! - (24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
        else if segment.selectedSegmentIndex == 1 {
            
            currentstartdate = currentstartdate! - (7 * 24 * 60 * 60)
            currentenddate = currentenddate! - (7 * 24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
        else {
             currentstartdate = currentstartdate! - (30 * 24 * 60 * 60)
            currentenddate = currentenddate! - (30 * 24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
    }
    
    
    @IBAction func nextbtntapped(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            currentstartdate = currentstartdate! + (24 * 60 * 60)
            currentenddate = currentenddate! + (24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
        else if segment.selectedSegmentIndex == 1 {
            
            currentstartdate = currentstartdate! + (7 * 24 * 60 * 60)
            currentenddate = currentenddate! + (7 * 24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
        else {
             currentstartdate = currentstartdate! + (30 * 24 * 60 * 60)
            currentenddate = currentenddate! + (30 * 24 * 60 * 60)
            self.fetchjusttotal(sd: currentstartdate!, ed: currentenddate!)
        }
    }
    
    
    @IBAction func addsalespurchasetapped(_ sender: Any) {
        self.hidelower()
        self.overfilterview.isHidden = false
    }
    
    
    @IBAction func choosecustomdatepicked(_ sender: Any) {
        self.hideupper()
        self.overfilterview.isHidden = false
    }
    
    
    
    @IBAction func filterviewbacktapped(_ sender: Any) {
        self.overfilterview.isHidden = true
    }
    
    
    @IBAction func segmentchangedforsalespurchase(_ sender: Any) {
        if salespurchasesegment.selectedSegmentIndex == 0 {
            self.addsaleslabel.text = "Add Sales"
            self.plusminuslabel.text = "+"
        }
        else {
            self.addsaleslabel.text = "Add Purchase"
            self.plusminuslabel.text =  "-"
        }
    }
    
    
    
    @IBAction func salesamountadded(_ sender: Any) {
        
        self.amounttextfield.resignFirstResponder()
        self.subjectfield.resignFirstResponder()
        self.view.endEditing(true)
        
        if self.amounttextfield.text == "" || self.amounttextfield.text == " " {
            Customalert.cs.showalert(x: "You need to enter amount", y: "")
        }
        
        else if let t = Int(self.amounttextfield.text ?? "") as? Int {
            var userid = KeychainWrapper.standard.string(forKey: "auth")!
            userid = "xytsha3527383"
            var amt = t
            var mode = "sales"
            if self.salespurchasesegment.selectedSegmentIndex == 0 {
                mode = "sales"
            }
            else {
                mode = "purchase"
                amt = -1 * t
            }
            self.salespurchaseaddbtn.isEnabled = false
            var tmp = FIRServerValue.timestamp()
            var d : Dictionary<String,Any> = ["addedby" : userid , "amount" : amt , "createdon" : tmp , "mode" : mode , "subject" : self.subjectfield.text ?? "" ]
            Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("records").childByAutoId().setValue(d) { (err, ref) in
                if err == nil {
                    Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("totalcount").child("\(amt)").setValue(tmp) { (err2, ref2) in
                        if err2 == nil {
                            self.overfilterview.isHidden = true
                            self.salespurchaseaddbtn.isEnabled = true
                            var rxx : Dictionary<String,Any> = [:]
                            if self.expensetype == "officeexpenses" {
                                 rxx  = ["lastused" : FIRServerValue.timestamp(),"name" : self.officeroomname , "profileimage" : "" , "type" : "office expenses" ]
                            }
                            else {
                                 rxx  = ["lastused" : FIRServerValue.timestamp(),"name" : self.officeroomname , "profileimage" : "" , "type" : "house expenses" ]
                            }
                            Dataservices.ds.users.child(userid).child("recents").child(self.officeroomid).setValue(rxx) { (reerr, reref) in
                                if reerr == nil {
                                    self.fetchjusttotal(sd: Date(), ed: Date())
                                }
                            }
                            
                            
                        }
                        else {
                            self.salespurchaseaddbtn.isEnabled = true
                            self.overfilterview.isHidden = true
                        }
                    }
                }
                else {
                    self.salespurchaseaddbtn.isEnabled = true
                    self.overfilterview.isHidden = true
                }
            }
            
        }
        else {
            Customalert.cs.showalert(x: "You need to enter numeric amount", y: "")
        }
        
        
    }
    
    
    
    @IBAction func viewallsalespurchasestapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "offdet") as! OfficeExpensesinDetailsViewController
            vc.officeroomid = self.officeroomid
            vc.startdate = self.currentstartdate
            vc.enddate = self.currentenddate
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = OfficeExpensesinDetailsViewController()
            vc.officeroomid = self.officeroomid
            vc.startdate = self.currentstartdate
            vc.enddate = self.currentenddate
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        self.performSegue(withIdentifier: "toexplain", sender: nil)
    }
    
    
    
    
    
    @IBAction func datechoosen(_ sender: Any) {
        self.currentstartdate = self.startdatepicker.date
        self.currentenddate = self.enddatepicker.date
        self.fetchjusttotal(sd: self.currentstartdate!, ed: self.currentenddate!)
        self.overfilterview.isHidden = true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? OfficeExpensesinDetailsViewController {
            seg.officeroomid = self.officeroomid
            seg.startdate = self.currentstartdate
            seg.enddate = self.currentenddate
        }
    }
    
    

}
