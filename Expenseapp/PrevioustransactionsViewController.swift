//
//  PrevioustransactionsViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/23/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class PrevioustransactionsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate{
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var bottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var topconstraint: NSLayoutConstraint!
    
    var passedcontact : contacts!
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarheading: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var filtertransactions: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var clearbtn: Custombtn!
    
    @IBOutlet weak var okbtn: Custombtn!
    // Filter Upper View
    
    
    @IBOutlet weak var filterview: CustomView!
    
    @IBOutlet weak var startdatelabel: UILabel!
    
    @IBOutlet weak var startdatepicker: UIDatePicker!
    
    @IBOutlet weak var enddatelabel: UILabel!
    
    @IBOutlet weak var enddatepicker: UIDatePicker!
    
    
    
    @IBOutlet weak var filterinnerremarks: UIView!
    
    @IBOutlet weak var remarkamount: UILabel!
    
    
    @IBOutlet weak var remarksubject: UILabel!
    
    @IBOutlet weak var remarkcomment: UITextView!
    
    @IBOutlet weak var remarkverified: UILabel!
    
    
    @IBOutlet weak var filterstack: UIStackView!
    
    @IBOutlet weak var okctackbtn: UIButton!
    
    
    var lastobtainedid = ""
    var segmentselectedmode = "all"
    var hasdatefiltered = false
    
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
        
        self.searchbar.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
              self.searchbar.barTintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.remarkamount.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
                self.remarksubject.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
                self.remarkcomment.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
                self.remarkverified.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.navbar.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.scrollview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        
         self.segment.tintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.segment.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
        let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimary()) ]
         segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
        segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
       
        
        
        self.navbarheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.okctackbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.okctackbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.clearbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.clearbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.okbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.okbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.filtertransactions.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.filtertransactions.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
        self.filterview.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.startdatelabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.enddatelabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())


        startdatepicker.setValue(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
        startdatepicker.setValue(false, forKey: "highlightsToday")

        enddatepicker.setValue(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), forKeyPath: "textColor")
        enddatepicker.setValue(false, forKey: "highlightsToday")
        
        
        self.filterinnerremarks.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.filterview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.filterview.layer.borderWidth = 2
        self.filterview.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.remarkamount.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.remarksubject.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.remarkcomment.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.remarkverified.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.okctackbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.okctackbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
//          self.filterview.frame = CGRect(x: 64, y: 16, width: self.scrollview.frame.width-32, height: self.scrollview.frame.height-128)
       
    }
    
    var records = [record]()
    var filteredrecords = [record]()
    var datewisefiltered = [record]()
    var searchedrecords = [record]()
    
    var searchmodeoon = false
    
    var pagefromstart = 2
    
    var startdate : Int64 = 0
    var enddate : Int64 = 0
    var srtd : Date?
    var endd : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.searchbar.delegate = self
        self.firstfetch()
        self.filterview.isHidden = true
        self.okctackbtn.layer.cornerRadius = 25
        print("passed contact")
        print(self.passedcontact)
         self.addbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        if let myImage = UIImage(named: "backpdf") {
                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                   self.addbtn.setImage(tintableImage, for: .normal)
               }
        
//        self.topconstraint.constant = self.scrollview.frame.height + 500
        
//        self.filterview.frame = CGRect(x: 64, y: 16, width: self.scrollview.frame.width-32, height: self.scrollview.frame.height-128)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchbar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let t = self.searchbar.text as? String {
            if t == "" || t == " " {
                self.searchmodeoon = false
                self.table.reloadData()
            }
            else {
                self.searchmodeoon = true
                searchedrecords = []
                if hasdatefiltered {
                    for each in datewisefiltered {
                        if each.category.lowercased().contains(find: t.lowercased()) || each.comment.lowercased().contains(find: t.lowercased()) || each.subject.lowercased().contains(find: t.lowercased()) || each.status.lowercased().contains(find: t.lowercased()) || each.title.lowercased().contains(find: t.lowercased()) {
                            searchedrecords.append(each)
                        }
                    }
                }
                else if(filteredrecords.count > 0)
                {
                    
                    for each in filteredrecords {
                        if each.category.lowercased().contains(find: t.lowercased()) || each.comment.lowercased().contains(find: t.lowercased()) || each.subject.lowercased().contains(find: t.lowercased()) || each.status.lowercased().contains(find: t.lowercased()) || each.title.lowercased().contains(find: t.lowercased()) {
                            searchedrecords.append(each)
                        }
                    }
                }
                else if filteredrecords.count == 0 && self.segmentselectedmode != "all" {
                    
                    for each in filteredrecords {
                        if each.category.lowercased().contains(find: t.lowercased()) || each.comment.lowercased().contains(find: t.lowercased()) || each.subject.lowercased().contains(find: t.lowercased()) || each.status.lowercased().contains(find: t.lowercased()) || each.title.lowercased().contains(find: t.lowercased()) {
                            searchedrecords.append(each)
                        }
                    }
                }
                else
                {
                    
                    for each in records {
                        if each.category.lowercased().contains(find: t.lowercased()) || each.comment.lowercased().contains(find: t.lowercased()) || each.subject.lowercased().contains(find: t.lowercased()) || each.status.lowercased().contains(find: t.lowercased()) || each.title.lowercased().contains(find: t.lowercased()) {
                            searchedrecords.append(each)
                        }
                    }
                }
                self.table.reloadData()
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.resignFirstResponder()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentpressed(_ sender: UISegmentedControl) {
        print(self.segment.selectedSegmentIndex)
        if(self.segment.selectedSegmentIndex == 0)
        {
            filterdata(param : "all")
        }
        else if(self.segment.selectedSegmentIndex == 1)
        {
            filterdata(param: "paid")
        }
        else if(self.segment.selectedSegmentIndex == 2)
        {
            filterdata(param: "received")
        }
    }
    
    
    @IBAction func profilepressed(_ sender: UIButton) {
    }
    
    @IBAction func addpressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okfilterpressed(_ sender: Custombtn) {
        
        hasdatefiltered = true
         self.srtd = self.startdatepicker.date
        self.endd = self.enddatepicker.date
        
        
        if (endd?.timeIntervalSince(srtd!).isLessThanOrEqualTo(0)) ?? false {
            self.present(Customalert.cs.showalert(x: "Start Date can not be later than End Date", y: ""), animated: true, completion: nil)
        }
        else {
            buildfilterrecords()
                   self.table.reloadData()
                   
                   
                    self.filterview.isHidden = true
                   self.filterinnerremarks.isHidden = true
                   self.filterstack.isHidden = true
        }
        
       

//        UIView.animate(withDuration: 3, animations: {
//            self.topconstraint.constant = self.scrollview.frame.size.height + 500
//            self.scrollview.layer.opacity = 1
//            self.filtertransactions.isHidden = false
//        }) { (true) in
//            print("hello")
//        }
    }
    
    
    
    
    
    @IBAction func cancelfilterpressed(_ sender: Custombtn) {
        self.startdate = 0
        self.enddate = 0
        self.srtd = nil
        self.endd = nil
        hasdatefiltered = false
        self.table.reloadData()
        
        
         self.filterview.isHidden = true
        self.filterinnerremarks.isHidden = true
        self.filterstack.isHidden = true
//        UIView.animate(withDuration: 3, animations: {
//            self.topconstraint.constant = self.scrollview.frame.size.height + 500
//            self.scrollview.layer.opacity = 1
//            self.filtertransactions.isHidden = false
//        }) { (true) in
//            print("hello")
//        }
    }
    
    @IBAction func filtertransactionpressed(_ sender: UIButton) {
        
        self.filterinnerremarks.isHidden = true
        self.filterstack.isHidden = false
       self.filterview.isHidden = false
//        UIView.animate(withDuration: 10, animations: {
//            self.topconstraint.constant = 64
//            self.scrollview.layer.opacity = 0.8
//            self.filtertransactions.isHidden = true
//        }) { (true) in
//            print("hello")
//        }
        
        
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

            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter.string(from: date as Date)
        }
        return ""
    }
    
    
    
    func dayDifference(ts : Int64 , d : Date) -> Int
    {
             var gd = TimeInterval(exactly: ts)
        if let xx = TimeInterval(ts) as? TimeInterval {
            let x = xx / 1000
            print("XX \(x)")
            
            let date = NSDate(timeIntervalSince1970: Double(x))
            
            return date.compare(d).rawValue
          
                
            
            
            
        }

        return 0
    }
    
    
    func buildfilterrecords()
    {
        self.datewisefiltered = []
        
        if self.filteredrecords.count == 0 && self.segmentselectedmode == "all" {
            for rec in self.records {
                print("Checking \(rec.date)  \(startdatepicker.date.timeIntervalSince1970) and \(startdatepicker.date) and \(enddatepicker.date)")
                var a  = self.dayDifference(ts: rec.date, d: startdatepicker.date)
                 var b = self.dayDifference(ts: rec.date, d: enddatepicker.date)
                print("\(a) and \(b)")
                if a == 1 && b == -1 {
                    self.datewisefiltered.append(rec)
                }
            }
        }
        else if self.filteredrecords.count > 0 {
            for rec in self.filteredrecords {
                print("Checking \(rec.date) and \(startdatepicker.date) and \(enddatepicker.date)")
                var a  = self.dayDifference(ts: rec.date, d: startdatepicker.date)
                var b = self.dayDifference(ts: rec.date, d: enddatepicker.date)
                print("\(a) and \(b)")
                if a == 1 && b == -1 {
                    self.datewisefiltered.append(rec)
                }
            }
        }
        print("Date wise record")
        print(self.datewisefiltered)
        self.table.reloadData()
    }
    
    
    
    
    
    
    func firstfetch()
    {
        var getidlock = false
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        print(userid)
        print(self.passedcontact.userid ?? "")
        
        Dataservices.ds.users.child("\(userid)").child("transactions").child(self.passedcontact.userid ?? "").queryOrderedByValue().queryLimited(toLast: 10).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? Dictionary<String,Any> {
                for each in value {
                    Dataservices.ds.transactions.child(each.key).observeSingleEvent(of: .value) { (ss) in
                        
                        if let snapy = ss.value as? Dictionary<String,Any> {
                            print(snapy["netamount"])
                            var am = 0
                            var da : Int64 = 0
                            var tl = ""
                            var trnsid = ss.key
                            var sta = ""
                            var cat = ""
                            var cmt = ""
                            var crt = ""
                            var pdby = ""
                            var rcvdby = ""
                            var sub = ""
                            var vrf = ""
                            
                            
                            
                            if let a = snapy["netamount"] as? Int {
                                am = a
                                print(am)
                            }
                            if let a = snapy["date"] as? Int64 {
                                print("Got \(a)")
                                da = a
                            }
                            if let a = snapy["category"] as? String {
                                cat = a
                            }
                            if let a = snapy["comment"] as? String {
                                cmt = a
                            }
                            if let a = snapy["creator"] as? String {
                                crt = a
                            }
                            if let a = snapy["paidby"] as? String {
                                pdby = a
                            }
                            if let a = snapy["receivedby"] as? String {
                                rcvdby = a
                            }
                            if let a = snapy["subject"] as? String {
                                sub = a
                            }
                            if let a = snapy["verified"] as? String {
                                vrf = a
                            }
                            
                            
                            if userid == pdby {
                                sta = "paid"
                            }
                            else {
                                sta = "received"
                            }
                       
                            print("Last ID \(trnsid)")
                            
                            var x = record(amount: "\(am)", date: da, title: sub, transactionid: trnsid ?? "", status: sta, category: cat, comment: cmt, creator: crt, paidby: pdby, receivedby: rcvdby, subject: sub, verified: vrf)
                            
                            self.records.insert(x, at: 0)
                            if !getidlock {
                                self.lastobtainedid = x.transactionid
                                getidlock = true
                            }
                             self.table.reloadData()
                             print("Last obtained is \(self.lastobtainedid)")

                            
                        }
                    }
                }
                
               
               
            }
        }
    }
    
    
    
    
    func fetchdata(pg : Int)
    {
        var getidlock = false
        
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
         userid = "xytsha3527383"
        print(userid)
        Dataservices.ds.users.child("\(userid)").child("transactions").child(self.passedcontact.userid ?? "").queryOrderedByValue().queryStarting(atValue: "\(self.lastobtainedid)").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? Dictionary<String,Any> {
                for each in value {
                    Dataservices.ds.transactions.child(each.key).observeSingleEvent(of: .value) { (ss) in
                        
                        if let snapy = ss.value as? Dictionary<String,Any> {
                            print(snapy["netamount"])
                            var am = 0
                            var da : Int64 = 0
                            var tl = ""
                            var trnsid = ss.key
                            var sta = ""
                            var cat = ""
                            var cmt = ""
                            var crt = ""
                            var pdby = ""
                            var rcvdby = ""
                            var sub = ""
                            var vrf = ""
                            
                            
                            
                            if let a = snapy["netamount"] as? Int {
                                am = a
                                print(am)
                            }
                            if let a = snapy["date"] as? Int64 {
                                print("Got \(a)")
                                da = a
                            }
                            if let a = snapy["category"] as? String {
                                cat = a
                            }
                            if let a = snapy["comment"] as? String {
                                cmt = a
                            }
                            if let a = snapy["creator"] as? String {
                                crt = a
                            }
                            if let a = snapy["paidby"] as? String {
                                pdby = a
                            }
                            if let a = snapy["receivedby"] as? String {
                                rcvdby = a
                            }
                            if let a = snapy["subject"] as? String {
                                sub = a
                            }
                            if let a = snapy["verified"] as? String {
                                vrf = a
                            }
                            
                            
                            if userid == pdby {
                                sta = "paid"
                            }
                            else {
                                sta = "received"
                            }
                       
                            
                            
                            var x = record(amount: "\(am)", date: da, title: sub, transactionid: trnsid ?? "", status: sta, category: cat, comment: cmt, creator: crt, paidby: pdby, receivedby: rcvdby, subject: sub, verified: vrf)
                            
                            self.records.insert(x, at: 0)
                            if !getidlock {
                                self.lastobtainedid = x.transactionid
                                getidlock = true
                            }
                            self.table.reloadData()
                             


                            
                        }
                    }
                }
                
                print("Last obtained is \(self.lastobtainedid)")
               
            }

        }
        
        
        
        
        
        
       
        
    }
    
    func filterdata(param:String)
    {
        self.segmentselectedmode = param
        self.filteredrecords.removeAll()
        self.filteredrecords = []
        if hasdatefiltered {
            for record in self.records
            {
                print("\(record.status) and \(param)")
                if(param == "all" || record.status == param)
                {
                    self.filteredrecords.append(record)
                }
            }
            self.buildfilterrecords()
            
        }
        else {
            for record in self.records
            {
                print("\(record.status) and \(param)")
                if(param == "all" || record.status == param)
                {
                    self.filteredrecords.append(record)
                }
            }
        }
        
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchmodeoon {
            return self.searchedrecords.count
        }
        else if hasdatefiltered {
            return datewisefiltered.count
        }
        else if(filteredrecords.count > 0)
        {
            return self.filteredrecords.count
        }
        else if filteredrecords.count == 0 && self.segmentselectedmode != "all" {
            return self.filteredrecords.count
        }
        else
        {
            return self.records.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recordcell", for: indexPath) as? PreviousRecordTableViewCell
        {
            if searchmodeoon {
                cell.updatecell(x: self.searchedrecords[indexPath.row].amount, y: convertTimestamp(serverTimestamp: self.searchedrecords[indexPath.row].date) , z: self.searchedrecords[indexPath.row].title  , w : self.searchedrecords[indexPath.row].status )
            }
            else if hasdatefiltered {
               cell.updatecell(x: self.datewisefiltered[indexPath.row].amount, y: convertTimestamp(serverTimestamp: self.datewisefiltered[indexPath.row].date) , z: self.datewisefiltered[indexPath.row].title  , w : self.datewisefiltered[indexPath.row].status )
            }
            else if(self.filteredrecords.count > 0)
            {
                cell.updatecell(x: self.filteredrecords[indexPath.row].amount, y: convertTimestamp(serverTimestamp: self.filteredrecords[indexPath.row].date) , z: self.filteredrecords[indexPath.row].title  , w : self.filteredrecords[indexPath.row].status )
            }
            else if filteredrecords.count == 0 && self.segmentselectedmode != "all" {
                cell.updatecell(x: self.filteredrecords[indexPath.row].amount, y: convertTimestamp(serverTimestamp: self.filteredrecords[indexPath.row].date) , z: self.filteredrecords[indexPath.row].title   , w : self.filteredrecords[indexPath.row].status )
            }
            else
            {
            cell.updatecell(x: self.records[indexPath.row].amount, y: convertTimestamp(serverTimestamp: self.records[indexPath.row].date), z: self.records[indexPath.row].title   , w : self.records[indexPath.row].status )
            }
            return cell
        }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasdatefiltered {
          let record = self.datewisefiltered[indexPath.row]
                self.configurepopup(x: record)
        }
        else if(self.filteredrecords.count > 0)
        {
           let record = self.filteredrecords[indexPath.row]
                 self.configurepopup(x: record)
        }
        else if filteredrecords.count == 0 && self.segmentselectedmode != "all" {
            let record = self.filteredrecords[indexPath.row]
                  self.configurepopup(x: record)
        }
        else
        {
            let record = self.records[indexPath.row]
                  self.configurepopup(x: record)
        }
      
        print(indexPath.row)
        
    }
    
    
    @IBAction func closetableviewpopup(_ sender: Any) {
        self.filterinnerremarks.isHidden = true
        self.filterstack.isHidden = true
        self.filterview.isHidden = true
        
    }
    
    func configurepopup(x : record)
    {
        self.filterinnerremarks.isHidden = false
        self.filterstack.isHidden = true
        self.filterview.isHidden = false
        

        
        
       
        
        self.remarkamount.text = x.amount
        self.remarksubject.text = "Subject : \(x.subject.capitalized)"
        self.remarkcomment.text = "Comment : \(x.comment.capitalized)"
        self.remarkverified.text = "Verified : \(x.verified.capitalized)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
