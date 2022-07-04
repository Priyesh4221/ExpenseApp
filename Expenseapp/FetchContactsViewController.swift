//
//  FetchContactsViewController.swift
//  Expenseapp
//
//  Created by admin on 05/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import ContactsUI
import SwiftKeychainWrapper

struct phonecontact
{
    var name : String
    var number : [String]
    var countrycode : [String]
}


class FetchContactsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , UIPickerViewDelegate , UIPickerViewDataSource,UISearchBarDelegate {
    
    
    
    @IBOutlet weak var overlay: UIView!
    
    @IBOutlet weak var overlayclose: UIButton!
    
    @IBOutlet weak var overlayimagecover: UIView!
    
    
    @IBOutlet weak var overlayimage: UIImageView!
    
    
    @IBOutlet weak var selectedname: UILabel!
    
    @IBOutlet weak var chooseanumberlabel: UILabel!
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    
    
    @IBOutlet weak var confirmview: UIView!
    
    @IBOutlet weak var confirmviewclose: UIButton!
    
    @IBOutlet weak var confirmviewapproval: UIButton!
    
    
    @IBOutlet weak var confirmviewdenial: UIButton!
    
    @IBOutlet weak var confirmviewnumber: UILabel!
    
    @IBOutlet weak var confirmviewmessage: UILabel!
    
    var allphonecontacts : [phonecontact] = []
    var filteredcont : [phonecontact] = []
    var exitinguser : Dictionary<String,Any>?
    var existinguserid = ""
    var useridtobetakenone = ""
    var useridtobetakentwo = ""
    var idtobepassedfinal = ""
    
    
    @IBOutlet weak var upperview: UIView!
    
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    @IBOutlet weak var countselected: UILabel!
    
    
    @IBOutlet weak var bottomview: UIView!
    
    
    @IBOutlet weak var contactsheading: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var addbtn: UIButton!
    
    var selectedcontactinfo : phonecontact?
    
    
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
    
    func setupcolors(){
        print(Theme.theme.getsecondary())
        print(Theme.theme.getprimary())
        print(Theme.theme.getsecondaryfont())
        print(Theme.theme.getprimaryfont())
        
        self.searchbar.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.searchbar.barTintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.countselected.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.overlay.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.overlayclose.setTitleColor(hexStringToUIColor(hex : Theme.theme.getprimaryfont()), for: .normal)
        self.selectedname.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.chooseanumberlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.pickerview.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.confirmview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        self.confirmviewclose.setTitleColor(hexStringToUIColor(hex : Theme.theme.getprimaryfont()), for: .normal)
        self.confirmviewnumber.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.confirmviewmessage.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.confirmviewdenial.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.confirmviewdenial.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.confirmviewapproval.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.confirmviewapproval.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        
        
        
        
        self.overlayimagecover.layer.cornerRadius = self.overlayimagecover.frame.size.height/2
        self.overlayimage.layer.cornerRadius = self.overlayimage.frame.size.height/2
        self.overlayimagecover.backgroundColor = UIColor.clear
        self.overlayimage.backgroundColor = UIColor.clear
        
        self.overlayimagecover.backgroundColor = UIColor.clear
        self.overlayimagecover.layer.cornerRadius = 60
        self.overlayimagecover.layer.shadowPath = UIBezierPath(rect: self.overlayimagecover.bounds).cgPath
        self.overlayimagecover.layer.shadowRadius = 25
        self.overlayimagecover.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.overlayimagecover.layer.shadowOpacity = 0.35
        self.overlayimagecover.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.overlayimagecover.clipsToBounds = true
        
        
        self.upperview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.contactsheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.addbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        //        self.addbuttonheading.tintColor = UIColor(named : Theme.theme.getprimaryfont())
        //        self.profilebuttonheading.tintColor = UIColor(named : Theme.theme.getprimaryfont())
        
        
        
        //        self.splitbillbtn.tintColor = UIColor(named : Theme.theme.getsecondaryfont())
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchbar.resignFirstResponder()
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
        shapelayer.isHidden = false
        tracklayer.isHidden = false
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
    
    func stoploader()
    {
        shapelayer.isHidden = true
        tracklayer.isHidden = true
        shapelayer.removeAllAnimations()
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
                            arrPhoneNumbers.append(nm)
                        }
                        else {
                            arrPhoneNumbers.append(nm)
                        }
                        
                    }
                    
                }
            }
            var x = phonecontact(name: name, number: arrPhoneNumbers, countrycode: countrycodes)
            if arrPhoneNumbers.count > 0 {
                self.allphonecontacts.append(x)
            }
        }
        print("-------------")
        print(allphonecontacts) // here array has all contact numbers.
        self.table.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolors()
        phoneNumberWithContryCode()
        pickerview.delegate = self
        pickerview.dataSource = self
        overlay.isHidden = true
        confirmview.isHidden = true
        searchbar.delegate = self
        //        startloader()
        self.searchbar.layer.borderWidth = 2
        self.searchbar.layer.borderColor =  hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        let textField = searchbar.value(forKey: "searchField") as? UITextField
        textField?.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.backbtn.setImage(tintableImage, for: .normal)
        }
        
        addbtn.layer.cornerRadius = addbtn.frame.size.height/2
        confirmviewapproval.layer.cornerRadius = confirmviewapproval.frame.size.height/2
        confirmviewdenial.layer.cornerRadius = confirmviewdenial.frame.size.height/2
        table.delegate = self
        table.dataSource = self
        
        self.overlayimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        if let myImage = UIImage(named: "user") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.overlayimage.image = tintableImage
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Change")
        filteredcont = []
        if searchbar.text != "" || searchbar.text != " " {
            for each in allphonecontacts {
                var x = each.name ?? ""
                if (x.containsIgnoringCase(find: searchbar.text ?? "")) {
                    filteredcont.append(each)
                }
            }
            self.table.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredcont.count > 0 {
            return filteredcont.count
        }
        else {
            return allphonecontacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "fetchcontact", for: indexPath) as? FetchContactTableViewCell {
            if filteredcont.count > 0 {
                cell.updatecell(x : self.filteredcont[indexPath.row])
            }
            else {
                cell.updatecell(x : self.allphonecontacts[indexPath.row])
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredcont.count  > 0 {
            selectedcontactinfo = filteredcont[indexPath.row]
            self.selectedname.text = filteredcont[indexPath.row].name
        }
        else {
            selectedcontactinfo = allphonecontacts[indexPath.row]
            self.selectedname.text = allphonecontacts[indexPath.row].name
        }
        
        self.pickerview.reloadComponent(0)
        
        overlay.isHidden = false
        
    }
    
    @IBAction func addbtntapped(_ sender: Any) {
        
        if let number = self.selectedcontactinfo?.number[self.pickerview.selectedRow(inComponent: 0)] as? String , let name = self.selectedcontactinfo?.name as? String {
            self.confirmviewnumber.text = number
            startloader()
            self.existinguserid = ""
            self.checkexistence { (s, v) in
                self.stoploader()
                self.idtobepassedfinal = ""
                self.transactionalreadyaddedbyregistereduser(n: self.existinguserid) { (ah) in
                    if ah {
                        print("Got true from check 1 \(self.existinguserid)")
                        
                        let alart = UIAlertController(title: "Individual Already Added", message: "Please check your individual contacts list, seems like user with this number is already in your list.", preferredStyle: .actionSheet)
                        alart.modifyalertview()
                        alart.addAction(UIAlertAction(title: "Take me to the user details", style: .default, handler: { (al) in
                            self.idtobepassedfinal = self.useridtobetakenone
                            if self.idtobepassedfinal != "" {
                                if #available(iOS 13.0, *) {
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
                                    if self.idtobepassedfinal == "" {
                                        vc.justcontactuserid = self.existinguserid
                                    }
                                    else {
                                        vc.justcontactuserid = self.idtobepassedfinal
                                    }
                                    vc.dangeringoingback = true
                                    self.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    // Fallback on earlier versions
                                    let vc = ContactsindividualViewController()
                                    if self.idtobepassedfinal == "" {
                                        vc.justcontactuserid = self.existinguserid
                                    }
                                    else {
                                        vc.justcontactuserid = self.idtobepassedfinal
                                    }
                                    vc.dangeringoingback = true
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                //                                self.performSegue(withIdentifier: "direct", sender: nil)
                            }
                        }))
                        alart.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alart, animated: true, completion: nil)
                        
                        
                    }
                    else {
                        print("Got false from check 1 \(self.existinguserid)")
                        self.transactionalreadyaddedbyguestuser(n: "") { (lk) in
                            if lk {
                                print("Got true from check 2 \(self.existinguserid)")
                                let alart = UIAlertController(title: "Individual Already Added", message: "Please check your individual contacts list, seems like user with this number is already in your list.", preferredStyle: .actionSheet)
                                alart.modifyalertview()
                                alart.addAction(UIAlertAction(title: "Take me to the user details", style: .default, handler: { (al) in
                                    self.idtobepassedfinal = self.useridtobetakentwo
                                    if self.idtobepassedfinal != "" {
                                        if #available(iOS 13.0, *) {
                                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
                                            if self.idtobepassedfinal == "" {
                                                vc.justcontactuserid = self.existinguserid
                                            }
                                            else {
                                                vc.justcontactuserid = self.idtobepassedfinal
                                            }
                                            vc.dangeringoingback = true
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        } else {
                                            // Fallback on earlier versions
                                            let vc = ContactsindividualViewController()
                                            if self.idtobepassedfinal == "" {
                                                vc.justcontactuserid = self.existinguserid
                                            }
                                            else {
                                                vc.justcontactuserid = self.idtobepassedfinal
                                            }
                                            vc.dangeringoingback = true
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                        //                                        self.performSegue(withIdentifier: "direct", sender: nil)
                                    }
                                }))
                                alart.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                                self.present(alart, animated: true, completion: nil)
                            }
                            else {
                                print("Got false from check 2 \(self.existinguserid)")
                                self.confirmview.isHidden = false
                                self.overlay.isHidden = true
                                if s {
                                    self.confirmviewmessage.text = "User with above number has registered account. If you turn on cross verification , every transaction you add requires approval from \(name.capitalized) and the vice versa."
                                    self.confirmviewdenial.setTitle("No do not turn cross verification on", for: .normal)
                                    self.confirmviewapproval.setTitle("Yes turn cross verification on", for: .normal)
                                    self.exitinguser = v
                                }
                                else {
                                    self.confirmviewmessage.text = "User with above number does not have registered account. You can not turn on cross verification. You will be able to turn on the cross verification once this user joins."
                                    self.confirmviewdenial.setTitle("Invite to join", for: .normal)
                                    self.confirmviewapproval.setTitle("Add with out cross verification", for: .normal)
                                    self.exitinguser = nil
                                }
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
    typealias pass = (_ x : Bool) -> Void
    func transactionalreadyaddedbyregistereduser(n : String , _ y : @escaping pass) {
        self.useridtobetakenone = ""
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        print("Hello Existing user id is \(self.existinguserid)")
        if self.existinguserid == ""
        {
            y(false)
        }
        else
        {
            Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(self.existinguserid).observeSingleEvent(of: .value) { (strk) in
                self.useridtobetakenone = self.existinguserid
                if let ssh = strk.value as? Dictionary<String,Any> {
                    y(true)
                }
                else {
                    y(false)
                }
            }
        }
        
        
    }
    func transactionalreadyaddedbyguestuser(n : String , _ y : @escaping pass) {
        self.useridtobetakentwo = ""
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        if let number = self.selectedcontactinfo?.number[self.pickerview.selectedRow(inComponent: 0)] as? String {
            print("The number this time is \(number)")
            Dataservices.ds.users.child(userid).child("guestusersids").child("\(number)").observeSingleEvent(of: .value) { (nm) in
                print("Snapshot is \(nm)")
                
                if let nb = nm.value as? String {
                    print("String is \(nb)")
                    self.useridtobetakentwo = nb
                    Dataservices.ds.users.child(userid).child("contacts").child("individuals").child("\(nb)").observeSingleEvent(of: .value) { (strk) in
                        print("A snapshot is \(strk)")
                        print("A value is \(strk.value)")
                        if let ssh = strk.value as? Dictionary<String,Any> {
                            y(true)
                        }
                        else {
                            y(false)
                        }
                    }
                }
                else {
                    y(false)
                }
            }
            
        }
        
    }
    
    
    typealias passbackdata = (_ x : Bool , _ y : Dictionary<String,Any>?) -> Void
    func checkexistence(p : @escaping passbackdata)
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        if let number = self.selectedcontactinfo?.number[self.pickerview.selectedRow(inComponent: 0)] as? String {
            print("The number is \(number)")
            Dataservices.ds.home.child("appusers").child("\(number)").observeSingleEvent(of: .value) { (snapshot) in
                print(snapshot.value)
                if let snap = snapshot.value as? String{
                    print("Found with userid \(snap as? String)")
                    self.existinguserid = snap
                    Dataservices.ds.users.child(snap).child("basic").observeSingleEvent(of: .value) { (snnap) in
                        if let ss = snnap.value as? Dictionary<String,Any> {
                            print(ss)
                            p(true,ss)
                        }
                        else {
                            p(false,nil)
                        }
                    }
                    
                    
                    //                    var found = false
                    //                    print(snap)
                    //                    for each in snap {
                    //                        if each.key == number {
                    //                            found = true
                    //                            if let ui = each.value as? String {
                    //
                    //                            }
                    //                            else {p(false,nil)}
                    //                            print("Found with userid \(each.value as? String)")
                    //                        }
                    //                    }
                    
                }
                else {
                    print("Number did not found")
                    p(false,nil)
                    
                }
            }
        }
    }
    
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeoverlaytapped(_ sender: Any) {
        overlay.isHidden = true
    }
    
    
    @IBAction func closeconfirmview(_ sender: Any) {
        confirmview.isHidden = true
    }
    
    
    @IBAction func confrimviewdenialpressed(_ sender: Any) {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        if let v = self.exitinguser as? Dictionary<String,Any> {
            Dataservices.ds.users.child(userid).child("contacts").child("individuals").observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.hasChild("\(self.existinguserid)") {
                    
                }
                else {
                    var d : Dictionary<String,String> = ["crossverification" : "no","netamount" : "+0"]
                    Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(self.existinguserid).setValue(d) { (err, ref) in
                        if err == nil {
                            print("user added")
                            self.promtandtakebacktohome()
                        }
                    }
                }
            }
        }
        else {
            // Handle Invite to join
        }
    }
    
    func promtandtakebacktohome()
    {
        let alert = UIAlertController(title: "Added", message: "", preferredStyle: .actionSheet)
        alert.modifyalertview()
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (at) in
            
            if #available(iOS 13.0, *) {
                           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CustomTabBarViewController") as! CustomTabBarViewController
                           self.navigationController?.pushViewController(vc, animated: true)
                       } else {
                           // Fallback on earlier versions
                           let vc = CustomTabBarViewController()
                           self.navigationController?.pushViewController(vc, animated: true)
                       }
            
            
//            if #available(iOS 13.0, *) {
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
//                if self.idtobepassedfinal == "" {
//                    vc.justcontactuserid = self.existinguserid
//                }
//                else {
//                    vc.justcontactuserid = self.idtobepassedfinal
//                }
//                vc.dangeringoingback = true
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//                // Fallback on earlier versions
//                let vc = ContactsindividualViewController()
//                if self.idtobepassedfinal == "" {
//                    vc.justcontactuserid = self.existinguserid
//                }
//                else {
//                    vc.justcontactuserid = self.idtobepassedfinal
//                }
//                vc.dangeringoingback = true
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            //            self.performSegue(withIdentifier: "direct", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func confirmviewapprovalpressed(_ sender: Any) {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        if let v = self.exitinguser as? Dictionary<String,Any> {
            Dataservices.ds.users.child(userid).child("contacts").child("individuals").observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.hasChild("\(self.existinguserid)") {
                    
                }
                else {
                    var d : Dictionary<String,String> = ["crossverification" : "yes","netamount" : "+0.0"]
                    Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(self.existinguserid).setValue(d) { (err, ref) in
                        if err == nil {
                            print("user added")
                            self.promtandtakebacktohome()
                        }
                    }
                }
            }
        }
        else {
            if let number = self.selectedcontactinfo?.number[self.pickerview.selectedRow(inComponent: 0)] as? String {
                var key = Dataservices.ds.users.child(userid).child("guestusers").childByAutoId().key
                self.existinguserid = key
                var d : Dictionary<String,String> = ["currency" : "rupees",
                                                     "name" : "\(self.selectedcontactinfo?.name ?? "")",
                    "mobile" : "\(number)"]
                var e : Dictionary<String,String> = ["crossverification" : "no",
                                                     "netamount" : "+0.0"]
                Dataservices.ds.users.child(userid).child("guestusers").child(key).setValue(d) { (err, ref) in
                    if err == nil {
                        Dataservices.ds.users.child(userid).child("contacts").child("individuals").child(key).setValue(e) { (err1, ref1) in
                            if err1 == nil {
                                Dataservices.ds.users.child(userid).child("guestusersids").child("\(number)").setValue(key) { (err3, ref3) in
                                    if err3 == nil {
                                        self.promtandtakebacktohome()
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: selectedcontactinfo?.number[row] ?? "", attributes: [NSAttributedStringKey.foregroundColor : hexStringToUIColor(hex: Theme.theme.getprimaryfont())])
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectedcontactinfo?.number.count ?? 0
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ContactsindividualViewController {
            if self.idtobepassedfinal == "" {
                seg.justcontactuserid = self.existinguserid
            }
            else {
                seg.justcontactuserid = self.idtobepassedfinal
            }
            seg.dangeringoingback = true
        }
    }
    
    
}
