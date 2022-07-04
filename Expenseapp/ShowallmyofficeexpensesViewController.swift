//
//  ShowallmyofficeexpensesViewController.swift
//  Expenseapp
//
//  Created by admin on 27/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ShowallmyofficeexpensesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    
    var expensetype = "officeexpenses"
    
    
    
    @IBOutlet weak var closeoverlaybtn: UIButton!
    
    @IBOutlet weak var addnewofficelabel: UILabel!
    
    @IBOutlet weak var enterofficenamelabel: UILabel!
    
    
    @IBOutlet weak var officenamefield: UITextField!
    
    
    @IBOutlet weak var addofficenamebtn: UIButton!
    
    
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var upperview: UIView!
    
    
    @IBOutlet weak var bottomview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var officeexpenseslabel: UILabel!
    
    
    @IBOutlet weak var addnewouterview: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    var alldata : [fetchofficeexpenses] = []
    var selecteddata : fetchofficeexpenses?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupcolor()
        self.addnewouterview.isHidden = true
        if self.expensetype == "houseexpenses" {
            self.officeexpenseslabel.text = "House Expenses"
            self.addnewofficelabel.text = "Add New House"
            self.enterofficenamelabel.text = "Enter House Name"
            
        }
        
        
        fetchallexpenses()
        
        self.addbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

                      if let myImage = UIImage(named: "backpdf") {
                          let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                          self.backbtn.setImage(tintableImage, for: .normal)
                      }

        // Do any additional setup after loading the view.
    }
    
    func setupcolor()
    {
        self.addnewouterview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.upperview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.officeexpenseslabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.addbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.closeoverlaybtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.addofficenamebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.addofficenamebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.addofficenamebtn.layer.cornerRadius = self.addofficenamebtn.frame.size.height/2
        self.addnewofficelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.enterofficenamelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.officenamefield.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.officenamefield.layer.borderWidth = 1
        self.officenamefield.layer.cornerRadius = 10
        self.officenamefield.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.officenamefield.backgroundColor = UIColor.clear
        
    }
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.officenamefield.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func closeoverlaypressed(_ sender: Any) {
        self.officenamefield.resignFirstResponder()
        self.addnewouterview.isHidden = true
    }
    
    
    @IBAction func addnewofficepressed(_ sender: Any) {
        self.officenamefield.resignFirstResponder()
        if let t = self.officenamefield.text as? String {
            if t == "" || t == " " {
                var userid = KeychainWrapper.standard.string(forKey: "auth")!
                userid = "xytsha3527383"
                Dataservices.ds.users.child(userid).child("\(self.expensetype)").queryOrderedByValue().queryEqual(toValue: t).observeSingleEvent(of: .value) { (stt) in
                    if let ss = stt.value as? Dictionary<String,Any> {
                        print(ss)
                    }
                }
            }
            else {
                var userid = KeychainWrapper.standard.string(forKey: "auth")!
                userid = "xytsha3527383"
                self.addofficenamebtn.isEnabled = false
                Dataservices.ds.users.child(userid).child("\(self.expensetype)").queryOrdered(byChild: "name").queryEqual(toValue: t).observeSingleEvent(of: .value) { (stt) in
                    if let ss = stt.value as? Dictionary<String,Any> {
                        print(ss)
                        self.addofficenamebtn.isEnabled = true
                        if self.expensetype == "officeexpenses" {
                            self.present(Customalert.cs.showalert(x: "Can not add", y: "Office name \(t) already exists in your office expenses list. Try with some different name"), animated: true, completion: nil)
                        }
                        else if self.expensetype == "houseexpenses"{
                            self.present(Customalert.cs.showalert(x: "Can not add", y: "House name \(t) already exists in your house expenses list. Try with some different name"), animated: true, completion: nil)
                        }
                    }
                    else {
                        print("Not Found")
                        var key = Dataservices.ds.users.child(userid).child("\(self.expensetype)").childByAutoId().key
                        var officedata : Dictionary<String,Any> = ["name" : t]
                        Dataservices.ds.users.child(userid).child("\(self.expensetype)").child(key).setValue(officedata) { (errf, reff) in
                            if errf == nil {
                                var innerofficedata : Dictionary<String,Any> = ["roomname" : t , "creator" : userid]
                                Dataservices.ds.home.child("\(self.expensetype)").child(key).setValue(innerofficedata) { (innerr, refinn) in
                                    if innerr == nil {
                                        self.addnewouterview.isHidden = true
                                        self.fetchallexpenses()
                                        self.addofficenamebtn.isEnabled = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func addbtnclicked(_ sender: Any) {
        self.addnewouterview.isHidden = false
    }
    
    
    
    func fetchallexpenses()
    {
        shapelayer.isHidden = false
        tracklayer.isHidden = false
        self.startloader()
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        Dataservices.ds.users.child("\(userid)").child("\(self.expensetype)").observeSingleEvent(of: .value) { (osnap) in
            if let oo = osnap.value as? Dictionary<String,Any> {
                for each in oo {
                    Dataservices.ds.home.child("\(self.expensetype)").child(each.key).child("roomname").observeSingleEvent(of: .value) { (nameoff) in
                        if let offname = nameoff.value as? String {
                            var x = fetchofficeexpenses(name: offname, roomid: each.key)
                            self.alldata.append(x)
                            if osnap.childrenCount == self.alldata.count {
                                self.table.reloadData()
                                self.shapelayer.isHidden = true
                                self.tracklayer.isHidden = true
                            }
                            
                        }
                        else {
                            self.shapelayer.isHidden = false
                            self.tracklayer.isHidden = false
                        }
                    }
                }
                
            }
            else {
                self.shapelayer.isHidden = true
                self.tracklayer.isHidden = true
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alldata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "officecell", for: indexPath) as? ShowallmyofficeexpensesTableViewCell {
            cell.udpdate(x: self.alldata[indexPath.row] , y : self.expensetype)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecteddata = self.alldata[indexPath.row]
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "officesales") as! OfficeSalesViewController
            vc.expensetype = self.expensetype
            vc.officeroomid = self.selecteddata?.roomid ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = OfficeSalesViewController()
            vc.expensetype = self.expensetype
            vc.officeroomid = self.selecteddata?.roomid ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        performSegue(withIdentifier: "deepexpense", sender: nil)
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
       

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? OfficeSalesViewController {
            seg.expensetype = self.expensetype
            seg.officeroomid = self.selecteddata?.roomid ?? ""
        }
    }
    

}
