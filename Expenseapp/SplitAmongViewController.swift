//
//  SplitAmongViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/16/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import ContactsUI
import SwiftKeychainWrapper

class SplitAmongViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITableViewDelegate,UITableViewDataSource, UITextViewDelegate , UITextFieldDelegate , UISearchBarDelegate{
   
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var navbar: UIView!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var bottomlabel: UIView!
    
    @IBOutlet weak var bottomdescription: UILabel!
    @IBOutlet weak var footerlabel: UILabel!
    var users = [user]()
    var guestusers = [user]()
    var selectedusers = [user]()
    var allphonecontacts = [user]()
    
    var filteringon = false
    
    var fusers = [user]()
    var fguestusers = [user]()
    var fselectedusers = [user]()
    var fallphonecontacts = [user]()
    
    
     var splittedbillamount : Dictionary<String,Int> = [:]
    var billingamountbefore : Dictionary<String,Int> = [:]
    var billingamountlefttopay : Dictionary<String,Int> = [:]
    var ratioinwhichbillsplit : Dictionary<String,Int> = [ : ]

    var mode = "fixed"
    var state = ""
    var billtransaction : billsplittransaction?
    
    var guestusersdictionarykey : Dictionary<String,Bool> = [:]
  
    @IBOutlet weak var collection: UICollectionView!
    
    
    
    @IBOutlet weak var confirmationpopup: UIView!
    
    
    @IBOutlet weak var confirmationcancel: UIButton!
    
    @IBOutlet weak var confirmationheading: UILabel!
    
    
    @IBOutlet weak var confirmationproceed: UIButton!
    
    
    @IBOutlet weak var confirmationtable: UITableView!
    
    
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
        
        
        self.searchbar.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.searchbar.barTintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.footerlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.bottomdescription.textColor = hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
         self.bottomdescription.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.confirmationcancel.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.confirmationheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.confirmationproceed.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.confirmationproceed.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.confirmationpopup.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let t = self.searchbar.text as? String {
            if t == "" || t == " " {
                self.filteringon = false
                self.collection.reloadData()
            }
            else {
                
                fusers = []
                fguestusers = []
                fallphonecontacts = []
                
                for each in self.users {
                    if each.name.lowercased().contains(find: t.lowercased()) || each.email.lowercased().contains(find: t.lowercased()) {
                        self.fusers.append(each)
                    }
                }
                
                for each in self.guestusers {
                    if each.name.lowercased().contains(find: t.lowercased()) || each.email.lowercased().contains(find: t.lowercased()) {
                        self.fguestusers.append(each)
                    }
                }
                
                
                for each in self.allphonecontacts {
                    if each.name.lowercased().contains(find: t.lowercased()) || each.email.lowercased().contains(find: t.lowercased()) {
                        self.fallphonecontacts.append(each)
                    }
                }
                
                self.filteringon = true
                self.collection.reloadData()
            }
        }
    }
    
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
        startloader()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbar.delegate = self
        self.collection.delegate = self
        self.collection.dataSource = self
        self.confirmationtable.delegate = self
        self.confirmationtable.dataSource = self
        self.getguestusers()
        self.footerlabel.text = "\(self.selectedusers.count) Selected"
        self.confirmationpopup.isHidden = true
        
        self.confirmationproceed.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
        
        self.addbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

               if let myImage = UIImage(named: "backpdf") {
                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                   self.addbtn.setImage(tintableImage, for: .normal)
               }
        
        
    }
    
    
    
    func getContacts() -> [CNContact] { //  ContactsFilter is Enum find it below

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactGivenNameKey
            ] as [Any]

        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        return results
    }
    
    
    func phoneNumberWithContryCode()  {

        let contacts = getContacts() // here calling the getContacts methods\
        
        for contact in contacts {
            var name = ""
            var arrPhoneNumbers = [String]()
            var countrycodes = [String]()
            if let s = contact.givenName as? String {
                name = s
            }
            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
                    //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
                       if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                        var thiscc = ""
                            
                        if let MccNamVar2 = fulMobNumVar.value(forKey: "countryCode") as? String {
                            countrycodes.append(MccNamVar2)
                            thiscc = MccNamVar2
                        }
                        else {
                            countrycodes.append("")
                            thiscc = ""
                        }
                        var nm = MccNamVar
                        if nm.contains("+91") {
                            nm.removeFirst(3)
                            if let fou = guestusersdictionarykey[nm] as? Bool { } else {
                                arrPhoneNumbers.append(nm)
                            }
                        }
                        else {
                            if let fou = guestusersdictionarykey[nm] as? Bool { } else {
                                arrPhoneNumbers.append(nm)
                            }
                        }
                        
                    }
                   
                }
            }
            
            for each in arrPhoneNumbers {
                if name != "" && name.lowercased() != "spam" && name.lowercased() != " " {
                    var x = user(name: name, id: "phonecontact", selected: false, email: "", mobile: each, gender: "", profileimage: "", status: "phone", currency: "")
                    self.allphonecontacts.append(x)
                }
            }
            
        }
        self.fetchdata()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
 
    
    
    
    func getguestusers()
    {
        var userid = "xytsha3527383"
        Dataservices.ds.users.child(userid).child("guestusers").observeSingleEvent(of: .value) { (gsnap) in
            if let gg = gsnap.value as? Dictionary<String,Any> {
                for each in gg {
                    if let t = each.value as? Dictionary<String,Any> {
                        var name = ""
                        var mobile = ""
                        var currency = ""
                        if let c = t["name"] as? String {
                            name = c
                        }
                        if let c = t["mobile"] as? String {
                            mobile = c
                        }
                        if let c = t["currency"] as? String {
                            currency = c
                        }
                        var nw = user(name: name, id: each.key, selected: false, email: "", mobile: mobile, gender: "", profileimage: "", status: "guest", currency: currency)
                        self.guestusersdictionarykey[mobile] = true
                        self.guestusers.append(nw)
                    }
                }
                print("Guest users are")
                 print(self.guestusers)
                self.phoneNumberWithContryCode()
 
                
            }
        }
    }
    
    
    
    func fetchdata()
    {
        var userid = "xytsha3527383"
        
        Dataservices.ds.users.child(userid).child("contacts").child("individuals").observeSingleEvent(of: .value) { (snap) in
            if let res = snap.value as? Dictionary<String,Any> {
                print(res)
                for each in res {
                    print(each.key)
                    print(self.users)
                    self.innerdata(xy: each.key) { (st) in
                        
                        if st {
                            print("Snao count is \(snap.childrenCount)")
                            print("---------------------------")
                                                           print(self.users)
                                                   self.collection.reloadData()
                                                   self.shapelayer.removeAllAnimations()
                                                   self.tracklayer.removeAllAnimations()
                                                   self.shapelayer.isHidden = true
                                                   self.tracklayer.isHidden = true
                            
                           
                               
                        }
                                
                            
                        
                    }
                }
                
                
            }
        }
        
        
        
        
        
        
    }
    
    
    
    
    func innerdata(xy : String , completionHandler: @escaping (_ success:Bool) -> Void)
    {
        Dataservices.ds.users.child("\(xy)").child("basic").observeSingleEvent(of: .value) { (ss) in
            if let x = ss.value as? Dictionary<String,Any> {
                print(x)
                var n = ""
                var e = ""
                var m = ""
                var g = ""
                var p = ""
                var s = ""
                var c = ""
                if let a = x["name"] as? String {
                    n = a
                }
                if let a = x["email"] as? String {
                    e = a
                }
                if let a = x["mobile"] as? String {
                    m = a
                }
                if let a = x["gender"] as? String {
                    g = a
                }
                if let a = x["profileimage"] as? String {
                    p = a
                }
                if let a = x["status"] as? String {
                    s = a
                }
                if let a = x["currency"] as? String {
                    c = a
                }
                
                
                var mm = user(name: n, id: xy, selected: false, email: e, mobile: m, gender: g, profileimage: p, status: s, currency: c)
                self.users.append(mm)
 

                
                completionHandler(true)
            }
            else {
                completionHandler(false)
            }
        }

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
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func gonext(_ sender: UIButton) {
        
        var should = 0
        
        self.searchbar.resignFirstResponder()
        for each in self.selectedusers {
            if each.id == "phonecontact" {
                should = should + 1
            }
        }
        
        
        if should == 0 {
            if let t = self.billtransaction?.amount as? Double {
                if t > 0 {
                    self.confirmationtable.reloadData()
                    self.confirmationpopup.isHidden = false
                }
                else {
                    self.present(Customalert.cs.showalert(x: "Amount Invalid", y: "Bill amount should be greater than 0."), animated: true, completion: nil)
                }
            }
        }
        else {
            self.registerphonecontactsasguestuser(x: should) { (st) in
                if st {
                    print(self.selectedusers)
                    if let t = self.billtransaction?.amount as? Double {
                        if t > 0 {
                            self.confirmationtable.reloadData()
                            self.confirmationpopup.isHidden = false
                        }
                        else {
                            self.present(Customalert.cs.showalert(x: "Amount Invalid", y: "Bill amount should be greater than 0."), animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        
        
        
        
        

        
       
        
        
    }
    
    func registerphonecontactsasguestuser(x: Int,completionHandler: @escaping (_ success:Bool) -> Void)
    {
      
            print("Sending Data ........")
            var userid = KeychainWrapper.standard.string(forKey: "auth")!
            userid = "xytsha3527383"
            var happened = 0
            for k in 0 ..< self.selectedusers.count {
                if self.selectedusers[k].id == "phonecontact" {
                    var key = Dataservices.ds.users.child(userid).child("guestusers").childByAutoId().key
                    var data : Dictionary<String,Any> = ["currency" : self.selectedusers[k].currency , "name" : self.selectedusers[k].name , "mobile" : self.selectedusers[k].mobile]
                    Dataservices.ds.users.child(userid).child("guestusers").child(key).setValue(data) { (err, ref) in
                        if err == nil {
                            self.selectedusers[k].id = key
                            happened = happened + 1
                            if x == happened {
                                
                                completionHandler(true)
                            }
                        }
                    }
                }
            }
        
        
        
        
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedusers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "confirmbill", for: indexPath) as? ConfirmbillamountTableViewCell {
            
            if let s = self.selectedusers[indexPath.row].id as? String {
                if let t = self.ratioinwhichbillsplit[s] {
                    
                }
                else {
                    print("No Value")
                    self.ratioinwhichbillsplit[s] = 1
                }
                
            }
            
           
            
            cell.update(x: self.selectedusers[indexPath.row] ,  y : billtransaction ?? billsplittransaction(billname: "", category: "", comment: "", mode: "", amount: 0.0, receipients: [], billamountsgenerated: [], duration: "", rate: 0.0, ranks: []), c : self.billingamountbefore , state : self.state , ratiopart : 1)
            
            cell.passbackamount = { a,b in
                for var each in self.selectedusers {
                    if b == each.id {
                        print("Aey")
                        print(b)
                        
                        if let c = Int(a) as? Int {
                            print(c)
                            each.billamountpaidinadvance = c ?? 0
                            self.billingamountbefore[b] = c
                        }
                        
                    }
                }
                print(self.selectedusers)
                print(self.billingamountbefore)
                
            }
            
            
            cell.takeratiopart = { a,b in
                for var each in self.selectedusers {
                    if b == each.id {
                        print("Aey")
                        print(b)
                        
                      
                            print(a)
                            each.ratioinwhichbillsplit = a
                            self.ratioinwhichbillsplit[b] = a
                        
                        
                    }
                }
                print(self.selectedusers)
                print(self.billingamountbefore)
                
            }
            
            
            
            cell.paidwholestatus = {a , b in
                print(a)
                print(b)
                if a {
                    for var each in self.selectedusers {
                        if b == each.id {
                            if let c = Int(self.billtransaction?.amount ?? 0) as? Int {
                                 each.billamountpaidinadvance = c
                                self.billingamountbefore[b] = c
                            }
                           
                        }
                        else {
                            each.billamountpaidinadvance = 0
                            self.billingamountbefore[each.id] = 0
                        }
                    }
                    print(self.billingamountbefore)
                    self.confirmationtable.reloadData()
                }
                else {
                    for var each in self.selectedusers {
                       
                            each.billamountpaidinadvance = 0
                            self.billingamountbefore[each.id] = 0
                        
                    }
                }
            }
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.state == "ratio" {
            return 280
        }
        return 250
    }
    
    @IBAction func cancelconfirm(_ sender: Any) {
        self.confirmationpopup.isHidden = true
    }
    
    
    
    @IBAction func proceedconfirmation(_ sender: Any) {
        
        for each in confirmationtable.visibleCells {
            if let c = each as? ConfirmbillamountTableViewCell {
                c.useramount.resignFirstResponder()
                c.userratiopart.resignFirstResponder()
            }
        }
        
        var sum = 0
        for each in billingamountbefore {
            sum = sum + each.value
        }
        var t = 0
        if let tt = Int(self.billtransaction?.amount ?? 0) as? Int {
            t = tt
        }
        
        print("Sum is \(sum)")
        print("Total is \(t)")
        
        if t != sum
        {
            self.present(Customalert.cs.showalert(x: "Amount Mismatched", y: "All individual amount should add up to total bill amount."), animated: true, completion: nil)
        }
        
        else if self.selectedusers.count < 2 {
            self.present(Customalert.cs.showalert(x: "Insufficient Users", y: "Please select atleast 2 users to split the bill"), animated: true, completion: nil)
        }
        else {
            
            
            print(self.billtransaction)
            
            
            if self.state == "equal"
            {
                if let b = self.billtransaction as? billsplittransaction {
                    if let bb = selectedusers as? [user] {
                        var indi = 0
                        
                        
                        indi = Int(self.billtransaction?.amount ?? 0) / (bb.count)
                        
                        print(indi)
                        for each in bb {
                            var iid = ""
                            if let i = each.id as? String {
                                self.splittedbillamount["\(i)"] = Int(indi)
                                var leftpayment =  Int(indi) - (self.billingamountbefore["\(i)"] ?? 0)
                                self.billingamountlefttopay["\(i)"] = leftpayment
                            }
                        }
                    }
                }
            }
            else if self.state == "ratio"
            {
                var error = false
                var totalratio = 0
                for each in self.ratioinwhichbillsplit {
                    if each.value < 1 {
                        error = true
                    }
                    else {
                        totalratio = totalratio + each.value
                    }
                }
                
                if error {
                    self.present(Customalert.cs.showalert(x: "Invalid Ratio", y: "Ratio paid by user has to be greater than 0"), animated: true, completion: nil)
                }
                else {
                    if let b = self.billtransaction as? billsplittransaction {
                        if let bb = selectedusers as? [user] {
                         
                            for each in bb {
                                var iid = ""
                                if let i = each.id as? String {
                                    var indi = 0
                                    var rp = 1
                                    if let r = self.ratioinwhichbillsplit["\(i)"] as? Int {
                                        rp = r
                                    }
                                    print("Ratio part \(rp)")
                                    print(totalratio)
                                    var hg = (Double(rp) / Double(totalratio))
                                    print(hg)
                                    indi = Int(Double(self.billtransaction?.amount ?? 0.0) * hg)
                                    print("This user will pay \(indi)")
                                    self.splittedbillamount["\(i)"] = Int(indi)
                                    var leftpayment =  Int(indi) - (self.billingamountbefore["\(i)"] ?? 0)
                                    self.billingamountlefttopay["\(i)"] = leftpayment
                                }
                            }
                        }
                    }

                }
                
                
            }
            
            
            
            
            
            print(splittedbillamount)
            print(billingamountlefttopay)
            
            
            self.billtransaction?.receipients = self.selectedusers
            if (self.mode == "fixed" && self.billtransaction?.category == "game")
            {
                if #available(iOS 13.0, *) {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "chrank") as! ChooseRankViewController
                    vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    // Fallback on earlier versions
                    let vc = ChooseRankViewController()
                    vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                }
//                performSegue(withIdentifier: "torankings", sender: nil)
            }
                
            else if self.mode == "timer"
            {
                if #available(iOS 13.0, *) {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sptim") as! SplitTimerViewController
                    vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    // Fallback on earlier versions
                    let vc = SplitTimerViewController()
                    vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                }
//                performSegue(withIdentifier: "totimer", sender: nil)
            }
            else if self.mode == "fixed"   // not the game one
            {
                if #available(iOS 13.0, *) {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "shwindi") as! ShowIndividualBillViewController
                    vc.billingamountlefttopay = self.billingamountlefttopay
                    vc.splittedbillamount = self.splittedbillamount
                    vc.billingamountbefore = self.billingamountbefore
                    vc.currentbill = self.billtransaction
                    vc.ratiosplit = self.ratioinwhichbillsplit
                    vc.allusersforbill = self.selectedusers
                    vc.mode = self.mode
                    vc.state = self.state
                    vc.comingrightaftercreating = true
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    // Fallback on earlier versions
                    let vc = ShowIndividualBillViewController()
                    vc.billingamountlefttopay = self.billingamountlefttopay
                    vc.splittedbillamount = self.splittedbillamount
                    vc.billingamountbefore = self.billingamountbefore
                    vc.currentbill = self.billtransaction
                    vc.ratiosplit = self.ratioinwhichbillsplit
                    vc.allusersforbill = self.selectedusers
                    vc.mode = self.mode
                    vc.state = self.state
                    vc.comingrightaftercreating = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
//                performSegue(withIdentifier: "newresult", sender: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchbar.resignFirstResponder()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if self.filteringon {
                return self.fusers.count
            }
            else {
                return self.users.count
            }
            
        }
        else if section == 1 {
            if self.filteringon {
                return self.fguestusers.count
            }
            else {
                return self.guestusers.count
            }
            
        }
        else {
            if self.filteringon {
                return self.fallphonecontacts.count
            }
            else {
                return self.allphonecontacts.count
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usercell", for: indexPath) as? SplitAmongCollectionViewCell
        {
            
            if indexPath.section == 0 {
                if self.filteringon {
                    cell.updatecell(x: self.fusers[indexPath.row])
                }
                else {
                    cell.updatecell(x: self.users[indexPath.row])
                }
                
            }
            else if indexPath.section == 1 {
                if self.filteringon {
                    cell.updatecell(x: self.fguestusers[indexPath.row])
                }
                else {
                    cell.updatecell(x: self.guestusers[indexPath.row])
                }
                
            }
            else {
                if self.filteringon {
                    cell.updatecell(x: self.fallphonecontacts[indexPath.row])
                }
                else {
                    cell.updatecell(x: self.allphonecontacts[indexPath.row])
                }
                
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if let cell = collectionView.cellForItem(at: indexPath) as? SplitAmongCollectionViewCell
        {
            if indexPath.section == 0 {
                if !self.filteringon {
                    if self.users[indexPath.row].selected == false
                    {
                        self.users[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.users[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.users[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.users[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
                else {
                    if self.fusers[indexPath.row].selected == false
                    {
                        self.fusers[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.fusers[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.fusers[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.fusers[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
            }
            else if indexPath.section == 1 {
                if !self.filteringon {
                    if self.guestusers[indexPath.row].selected == false
                    {
                        self.guestusers[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.guestusers[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.guestusers[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.guestusers[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
                else {
                    if self.fguestusers[indexPath.row].selected == false
                    {
                        self.fguestusers[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.fguestusers[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.fguestusers[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.fguestusers[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
            }
            else {
                if !self.filteringon {
                    if self.allphonecontacts[indexPath.row].selected == false
                    {
                        self.allphonecontacts[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.allphonecontacts[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.allphonecontacts[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.allphonecontacts[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
                else {
                    if self.fallphonecontacts[indexPath.row].selected == false
                    {
                        self.fallphonecontacts[indexPath.row].selected = true
                        cell.toggleselection(x : false)
                        self.selectedusers.append(self.fallphonecontacts[indexPath.row])
                        self.footerlabel.text = "\(self.selectedusers.count) Selected"
                        
                        
                    }
                    else
                    {
                        self.fallphonecontacts[indexPath.row].selected = false
                        cell.toggleselection(x : true)
                        
                        for index in 0..<self.selectedusers.count {
                            print("Index is \(index) and total is \(self.selectedusers.count)")
                            if(index < self.selectedusers.count)
                            {
                                if self.selectedusers[index].id == self.fallphonecontacts[indexPath.row].id && index < self.selectedusers.count
                                {
                                    self.selectedusers.remove(at:index)
                                    self.footerlabel.text = "\(self.selectedusers.count) Selected"
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                }
            }
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var s = CGSize(width: self.collection.frame.width/2.10, height: 200)
        return s
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SpliAmongCollectionCollectionReusableView{
            sectionHeader.head.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
            if indexPath.section == 0 {
                if self.users.count > 0 {
                    sectionHeader.head.text = "Contacts Enrolled in Expense App"
                }
                else {
                    sectionHeader.head.text = ""
                }
            }
            else if indexPath.section == 1 {
                if self.guestusers.count > 0 {
                    sectionHeader.head.text = "Guest Contacts whom you already added"
                }
                else {
                    sectionHeader.head.text = ""
                }
            }
            else {
                if self.allphonecontacts.count > 0 {
                    sectionHeader.head.text = "Phone Contacts"
                }
                else {
                    sectionHeader.head.text = ""
                }
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }

   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
       // Pass parameter into this function according to your requirement
    
        return CGSize(width:self.collection.frame.size.width , height: 50)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let seg = segue.destination as? SplitTimerViewController
        {
            seg.billtransaction = self.billtransaction
        }
        else if let seg = segue.destination as? ChooseRankViewController
        {
            seg.billtransaction = self.billtransaction
        }
        else if let seg = segue.destination as? BillSplitResultsViewController {
            seg.billingamountlefttopay = self.billingamountlefttopay
            seg.splittedbillamount = self.splittedbillamount
            seg.billingamountbefore = self.billingamountbefore
            seg.currentbill = self.billtransaction
            seg.ratiosplit = self.ratioinwhichbillsplit
            seg.allusersforbill = self.selectedusers
            seg.mode = self.mode
            seg.state = self.state
        }
        else if let seg = segue.destination as? ShowIndividualBillViewController {
            seg.billingamountlefttopay = self.billingamountlefttopay
            seg.splittedbillamount = self.splittedbillamount
            seg.billingamountbefore = self.billingamountbefore
            seg.currentbill = self.billtransaction
            seg.ratiosplit = self.ratioinwhichbillsplit
            seg.allusersforbill = self.selectedusers
            seg.mode = self.mode
            seg.state = self.state
            seg.comingrightaftercreating = true
        }
       
    }
    

}
