//
//  HomescreenViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/26/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


struct recentcontacts
{
    var name : String
    var profilephoto : String
    var recentlytransacted : Int64
    var type : String
    var userid : String
}

class HomescreenViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITableViewDelegate , UITableViewDataSource {

    static var passedrecents : ((_ x : Bool) -> Void)?
    var expensetype = "officeexpenses"
    var selecteduserid = ""
    
    var allrecents : [recentcontacts] = []
    var allpromotions : [String] = []
    
    @IBOutlet weak var notificationbtn: UIButton!
    
    
    @IBOutlet weak var collectionheight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var notifcount: UIButton!
    
    @IBOutlet weak var notificonwrapper: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var recentslabel: UILabel!
    
    
    @IBOutlet weak var screentitlelabel: UILabel!
    
    
    @IBOutlet weak var tabletop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate = self
        self.collection.dataSource = self
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData()
        
        self.fetchdummuydata()
        self.setupcolors()
        
        
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
                  userid = "xytsha3527383"
        Dataservices.ds.users.child(userid).child("unseennotificationscount").observe(.value) { (sn) in
            if let st = sn.value as? Int {
                if st == 0 {
                    self.notificonwrapper.isHidden = true
                }
                else {
                    self.notificonwrapper.isHidden = false
                    self.notifcount.setTitle("\(st)", for: .normal)
                }
            }
        }
        
        
        
        HomescreenViewController.passedrecents = {a in
            if a {
                self.allrecents = []
                self.fetchdummuydata()
            }
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collection!.collectionViewLayout = layout
        collection.allowsSelection = true
        collection.allowsMultipleSelection = false
        
        self.notificationbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "bell-solid") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.notificationbtn.setImage(tintableImage, for: .normal)
            }
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func notificationtapped(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "notifications") as! NotificationsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = NotificationsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    func setupcolors()
    {
        self.view.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.recentslabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.screentitlelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.notifcount.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.notifcount.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.notifcount.layer.cornerRadius = self.notifcount.frame.size.height/2
        self.notificonwrapper.layer.cornerRadius = self.notificonwrapper.frame.size.height/2

        self.notificonwrapper.layer.shadowPath = UIBezierPath(rect: self.notifcount.bounds).cgPath
        self.notificonwrapper.layer.shadowRadius = 8
        self.notificonwrapper.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.notificonwrapper.layer.shadowOpacity = 0.85
        self.notificonwrapper.layer.shadowColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.notificonwrapper.clipsToBounds = true
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "promotioncell", for: indexPath) as? PromotionsTableViewCell {
                cell.update()
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "categorytable", for: indexPath) as? CategoryTableViewCell {
                
                cell.takeback = {a in
                    if a == "bills" {
                        if #available(iOS 13.0, *) {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "showbills") as! ShowallmybillsViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            // Fallback on earlier versions
                            let vc = ShowallmybillsViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
//                        self.performSegue(withIdentifier: "seeallbills", sender: nil)
                    }
                    else if a == "office expenses" {
                        self.expensetype = "officeexpenses"
                        
                        if #available(iOS 13.0, *) {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "alloffices") as! ShowallmyofficeexpensesViewController
                            vc.expensetype = self.expensetype
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            // Fallback on earlier versions
                            let vc = ShowallmyofficeexpensesViewController()
                            vc.expensetype = self.expensetype
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
//                            self.performSegue(withIdentifier: "alloffice", sender: nil)
                    }
                    else if a == "house expenses" {
                        self.expensetype = "houseexpenses"
                        if #available(iOS 13.0, *) {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "alloffices") as! ShowallmyofficeexpensesViewController
                            vc.expensetype = self.expensetype
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            // Fallback on earlier versions
                            let vc = ShowallmyofficeexpensesViewController()
                            vc.expensetype = self.expensetype
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
//                            self.performSegue(withIdentifier: "alloffice", sender: nil)
                    }
                    else {
                        
                        if #available(iOS 13.0, *) {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "goeach") as! ContactsViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            // Fallback on earlier versions
                            let vc = ContactsViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
//                        self.performSegue(withIdentifier: "gotoeach", sender: nil)
                    }
                    
                }
                cell.update()
                return cell
            }
            
            
        }
        
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 210
        }
        else {
            return 500
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
    
    
    func stoploader()
    {
        self.shapelayer.isHidden = true
        self.tracklayer.isHidden = true
        self.shapelayer.removeAllAnimations()
    }
    
    
    
    func fetchdummuydata()
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
             userid = "xytsha3527383"
        self.startloader()
        Dataservices.ds.users.child(userid).child("recents").queryOrdered(byChild: "lastused").queryLimited(toLast: 10).observeSingleEvent(of: .value) { (snapshot) in
            if let ss = snapshot.value as? Dictionary<String,Any> {
                print(ss)
                for each in ss {
                    if let ee = each.value as? Dictionary<String,Any> {
                        var name = ""
                        var lastused : Int64 = 0
                        var profileimage = ""
                        var type = ""
                        var key = each.key
                        if let e = ee["name"] as? String {
                            name = e
                        }
                        if let e = ee["type"] as? String {
                            type = e
                        }
                        if let e = ee["lastused"] as? Int64 {
                            lastused = e
                        }
                        if let e = ee["profileimage"] as? String {
                            profileimage = e
                        }
                        var x = recentcontacts(name: name, profilephoto: profileimage, recentlytransacted: lastused, type: type, userid: key)
                               self.allrecents.insert(x, at: 0)
                        print(x)
                    }
                }
                self.allrecents.sort { (a, b) -> Bool in
                    a.recentlytransacted > b.recentlytransacted
                }
                if self.allrecents.count == 0 {
                    self.recentslabel.isHidden = true
                    self.collection.isHidden = true
                    self.tabletop.constant = -140
                }
                else {
                    self.recentslabel.isHidden = false
                    self.collection.isHidden = false
                    self.tabletop.constant = 0
                }
                self.stoploader()
                self.collection.reloadData()
            }
            else {
                self.stoploader()
            }
        }
        
        
        
        

        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allrecents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentcell", for: indexPath) as? HomescreenCollectionViewCell {
            cell.update(x : self.allrecents[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if allrecents[indexPath.row].type == "individual" {
            self.selecteduserid = allrecents[indexPath.row].userid
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactsindividual") as! ContactsindividualViewController
                vc.justcontactuserid = self.selecteduserid
                vc.refreshdata = { a in
                    if a {
                        
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = ContactsindividualViewController()
                vc.justcontactuserid = self.selecteduserid
                vc.refreshdata = { a in
                    if a {
                        
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            self.performSegue(withIdentifier: "contactinfo", sender: nil)
        }
        else if allrecents[indexPath.row].type == "billsplit" {
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "showbills") as! ShowallmybillsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = ShowallmybillsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            self.performSegue(withIdentifier: "seeallbills", sender: nil)
        }
        else if allrecents[indexPath.row].type == "office expenses" {
            self.expensetype = "officeexpenses"
            self.selecteduserid = allrecents[indexPath.row].userid
            
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "officesales") as! OfficeSalesViewController
                vc.expensetype = self.expensetype
                vc.officeroomid = self.selecteduserid
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = OfficeSalesViewController()
                vc.expensetype = self.expensetype
                vc.officeroomid = self.selecteduserid
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            self.performSegue(withIdentifier: "directoffice", sender: nil)
        }
        else if allrecents[indexPath.row].type == "house expenses" {
            self.expensetype = "houseexpenses"
            self.selecteduserid = allrecents[indexPath.row].userid
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "officesales") as! OfficeSalesViewController
                vc.expensetype = self.expensetype
                vc.officeroomid = self.selecteduserid
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = OfficeSalesViewController()
                vc.expensetype = self.expensetype
                vc.officeroomid = self.selecteduserid
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            self.performSegue(withIdentifier: "directoffice", sender: nil)
        }
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ContactsindividualViewController
        {
            if segue.identifier == "contactinfo"
            {
                print("Tapped \(self.selecteduserid)")
                seg.justcontactuserid = self.selecteduserid
            }
            
            seg.refreshdata = { a in
                if a {
                    
                }
            }
        }
        
        if let seg = segue.destination as? ShowallmyofficeexpensesViewController {
            seg.expensetype = self.expensetype
        }
       
        
        if let seg = segue.destination as? OfficeSalesViewController {
            seg.expensetype = self.expensetype
            seg.officeroomid = self.selecteduserid
        }
        
        
    }
    

}


extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}






class PaddedImageView: UIImageView {
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
}

extension UIAlertController {
    func modifyalertview() {
        self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.view.tintColor =  Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())

    }
}
