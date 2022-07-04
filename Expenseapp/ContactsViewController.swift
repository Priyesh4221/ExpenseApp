//
//  ContactsViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/22/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper


class ContactsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
   
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    // Primary Color
    
    @IBOutlet weak var headernavbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    // Primary Font Color
    
    @IBOutlet weak var contactsheading: UILabel!
    @IBOutlet weak var addbuttonheading: UIButton!
    @IBOutlet weak var profilebuttonheading: UIButton!
    
   
    
    // Primary Font Color Border
    @IBOutlet weak var notificationbtn: UIImage!
    
    // Secondary Background & Font Color
    
    @IBOutlet weak var splitbillbtn: UIButton!
    
    var type = "individuals"
    
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

        
        self.headernavbar.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.scrollview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.contactsheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbuttonheading.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
//        self.addbuttonheading.tintColor = UIColor(named : Theme.theme.getprimaryfont())
        self.profilebuttonheading.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
//        self.profilebuttonheading.tintColor = UIColor(named : Theme.theme.getprimaryfont())
        
        
        self.splitbillbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.splitbillbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
//        self.splitbillbtn.tintColor = UIColor(named : Theme.theme.getsecondaryfont())
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
        startloader()
        print("Heyya 2")
        self.searchbar.layer.borderWidth = 2
        self.searchbar.layer.borderColor =  hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        let textField = searchbar.value(forKey: "searchField") as? UITextField
        textField?.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        self.addbuttonheading.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.addbuttonheading.setImage(tintableImage, for: .normal)
        }

    }
//
//    override func viewDidLayoutSubviews() {
//        setupcolors()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        setupcolors()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        setupcolors()
//    }
    
    
    @IBOutlet weak var table: UITableView!
    var individualcont = [contacts]()
    var filteredcont = [contacts]()
    var teachercontacts = [contacts]()
    var workercontacts = [contacts]()
    var selectedcontact : contacts!
    
    @IBAction func profilepressed(_ sender: UIButton) {
    }
    
    @IBAction func addpressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func splitbillpressed(_ sender: UIButton) {
    }
    var userid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userid = KeychainWrapper.standard.string(forKey: "auth")!
        self.userid = "xytsha3527383"
        self.table.delegate = self
        self.table.dataSource = self
        print("Heyya")
        startloader()
        searchbar.delegate = self
        searchbar.enablesReturnKeyAutomatically = true
        
        fetchdata()

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
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Begin")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Change")
        filteredcont = []
        if searchbar.text != "" || searchbar.text != " " {
            for each in individualcont {
                var x = each.name ?? ""
                if (x.containsIgnoringCase(find: searchbar.text ?? "")) {
                    filteredcont.append(each)
                }
            }
            self.table.reloadData()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchbar.resignFirstResponder()
    }
    

    
    
    
    func fetchdata()
    {
        
        
        if(self.type.lowercased() == "individuals") {
            if self.individualcont.count > 0 {
                return
            }
        }
        else if self.type.lowercased() == "teachers"
        {
            if self.teachercontacts.count > 0 {
                return
            }
        }
        else if self.type.lowercased() == "workers"
        {
            if self.workercontacts.count > 0 {
                return
            }
        }
        
        
        
        Dataservices.ds.users.child("\(self.userid)/contacts/\(self.type)").observeSingleEvent(of: .value) { (snapshot) in
            if let results = snapshot.value as? Dictionary<String,AnyObject>
            {
                for r in results
                {
                    if let key = r.key as? String
                    {
                        print("key")
                        print(key)
                        if let con = r.value as? Dictionary<String,AnyObject>
                        {
                            var cv = con["crossverification"] as? Bool
                            if let c = cv {
                                
                            }
                            else {
                                cv = false
                            }
                            
                            
                            var amt = con["netamount"] as? String
                            if let a = amt
                            {
                                
                            }
                            else {
                                amt = "0"
                            }
                            
                            
                            Dataservices.ds.users.child("\(key)").child("basic").observeSingleEvent(of: .value) { (snap) in
                                if let sr = snap.value as? Dictionary<String,AnyObject>
                                {
                                    var n = ""
                                    var e = ""
                                    var p = ""
                                    var s = ""
                                    var g = ""
                                    var cu = ""
                                    
                                    
                                    if let  name = sr["name"] as? String {
                                        n = name
                                    }
                                    if let email = sr["email"] as? String {
                                        e = email
                                    }
                                    if let  profileimage = sr["profileimage"] as? String {
                                        p = profileimage
                                    }
                                    if let status = sr["status"] as? String {
                                        s = status
                                    }
                                    if let gender = sr["gender"] as? String {
                                        g = gender
                                    }
                                    if let currency = sr["currency"] as? String {
                                        cu = currency
                                    }
                                    var c = contacts(name: n, type: self.type, amount: amt, userid: key, profileimage: p , gender: g, email: e, status:s, currency:cu ,crossverification : cv )
                                    print("Further info")
                                    print(c)
                                    
                                    if(self.type.lowercased() == "individuals") {
                                        self.individualcont.append(c)
                                    }
                                    else if self.type.lowercased() == "teachers"
                                    {
                                        self.teachercontacts.append(c)
                                    }
                                    else if self.type.lowercased() == "workers"
                                    {
                                        self.workercontacts.append(c)
                                    }
                                    
                                    
                                    self.shapelayer.isHidden = true
                                    self.tracklayer.isHidden = true
                                    self.table.reloadData()
                                }
                                else {
                                    print("Going guest")
                                    print(self.userid)
                                    print(key)
                                    Dataservices.ds.users.child(self.userid).child("guestusers").child(key).observeSingleEvent(of: .value) { (snappy) in
                                        if let sr = snappy.value as? Dictionary<String,Any> {
                                            var n = ""
                                            var e = ""
                                            var p = ""
                                            var s = ""
                                            var g = ""
                                            var cu = ""
                                            if let  name = sr["name"] as? String {
                                                n = name
                                            }
                                            if let email = sr["email"] as? String {
                                                e = email
                                            }
                                            if let  profileimage = sr["profileimage"] as? String {
                                                p = profileimage
                                            }
                                            if let status = sr["status"] as? String {
                                                s = status
                                            }
                                            if let gender = sr["gender"] as? String {
                                                g = gender
                                            }
                                            if let currency = sr["currency"] as? String {
                                                cu = currency
                                            }
                                            var c = contacts(name: n, type: self.type, amount: amt, userid: key, profileimage: p , gender: g, email: e, status:s, currency:cu ,crossverification : cv )
                                            print("Further info")
                                            print(c)
                                            
                                            if(self.type.lowercased() == "individuals") {
                                                self.individualcont.append(c)
                                            }
                                            else if self.type.lowercased() == "teachers"
                                            {
                                                self.teachercontacts.append(c)
                                            }
                                            else if self.type.lowercased() == "workers"
                                            {
                                                self.workercontacts.append(c)
                                            }
                                            
                                            
                                            self.shapelayer.isHidden = true
                                            self.tracklayer.isHidden = true
                                            self.table.reloadData()
                                        }
                                    }
                                }

                            }
                            
                    
                        }
                        
                        
                    }
                }
                
                //            self.shapelayer.removeAllAnimations()
            }
        }
        
        
        
        
      
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredcont.count > 0 {
            return filteredcont.count
        }
        else {
            return self.individualcont.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell", for: indexPath) as? ContactTableViewCell
        {
            print()
            if filteredcont.count > 0 {
                cell.updatecell(x: self.filteredcont[indexPath.row].name!, y: self.filteredcont[indexPath.row].type!, z: self.filteredcont[indexPath.row].amount!)
                
            }
            else {
                cell.updatecell(x: self.individualcont[indexPath.row].name!, y: self.individualcont[indexPath.row].type!, z: self.individualcont[indexPath.row].amount!)
                
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredcont.count > 0 {
            selectedcontact = filteredcont[indexPath.row]
        }
        else {
            selectedcontact = individualcont[indexPath.row]
        }
        
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
            vc.passbackupdatedamount = { a,b in
                for each in 0 ..< self.individualcont.count {
                    if self.individualcont[each].userid == a.userid {
                        self.individualcont[each].amount = b
                        break
                    }
                }
            }
            vc.passedcontact = self.selectedcontact
            vc.refreshdata = { a in
                if a {
                     self.individualcont = []
                     self.teachercontacts = []
                    self.workercontacts = []
                    self.shapelayer.isHidden = false
                    self.tracklayer.isHidden = false
                    self.startloader()
                    self.fetchdata()
                }
            }

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = ContactsindividualViewController()
            vc.passedcontact = self.selectedcontact
               vc.refreshdata = { a in
                   if a {
                        self.individualcont = []
                        self.teachercontacts = []
                       self.workercontacts = []
                       self.shapelayer.isHidden = false
                       self.tracklayer.isHidden = false
                       self.startloader()
                       self.fetchdata()
                   }
               }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
            
//        performSegue(withIdentifier: "contactinfo", sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return self.view.frame.size.height/4 > 200 ? self.view.frame.size.height/4 : 200
       
    }
    
    
    @IBAction func addnewtapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "fetch") as! FetchContactsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = FetchContactsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ContactsindividualViewController
        {
            if segue.identifier == "contactinfo"
            {
                seg.passedcontact = self.selectedcontact
            }
            
            seg.refreshdata = { a in
                if a {
                     self.individualcont = []
                     self.teachercontacts = []
                    self.workercontacts = []
                    self.shapelayer.isHidden = false
                    self.tracklayer.isHidden = false
                    self.startloader()
                    self.fetchdata()
                }
            }
        }
    }
    

}


extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
