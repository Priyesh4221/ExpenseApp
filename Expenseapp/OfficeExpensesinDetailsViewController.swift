//
//  OfficeExpensesinDetailsViewController.swift
//  Expenseapp
//
//  Created by admin on 27/07/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class OfficeExpensesinDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var expensetype = "officeexpenses"
    
    @IBOutlet weak var nodata: UILabel!
    
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var bottomview: UIView!
    @IBOutlet weak var backbtn: UIButton!
    
    
    @IBOutlet weak var previoussaleslabel: UILabel!
    
    
    @IBOutlet weak var showingspanlabel: UILabel!
    
    
    @IBOutlet weak var table: UITableView!
    
    
    var officeroomid = ""
    var startdate : Date?
    var enddate : Date?
    
    
    var allrecords : [officeexpenserecord] = []
    
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
    
    func setupcolor()
    {
        self.upperview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.bottomview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.previoussaleslabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.showingspanlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.nodata.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
    }
    let monthsname = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupcolor()
        self.backbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

               if let myImage = UIImage(named: "backpdf") {
                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                   self.backbtn.setImage(tintableImage, for: .normal)
               }
        if let s = self.startdate as? Date , let e = self.enddate as? Date {
            let calendar = Calendar.current
                   let yx = calendar.component(.year, from: s)
                   let mx = calendar.component(.month, from: s)
                   let dx = calendar.component(.day, from: s)
                   
                   let yyx = calendar.component(.year, from: e)
                   let mmx = calendar.component(.month, from: e)
                   let ddx = calendar.component(.day, from: e)
            if s.timeIntervalSince1970 == e.timeIntervalSince1970 {
                self.showingspanlabel.text = "Showing for \(dx) \(monthsname[mx]) \(yx)"
            }
            else {
                self.showingspanlabel.text = "Showing from \(dx) \(monthsname[mx]) \(yx) To \(ddx) \(monthsname[mmx]) \(yyx)"
            }
            self.fetchdata(sd: s, ed: e)
        }
        
        

        // Do any additional setup after loading the view.
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
                self.shapelayer.isHidden = false
                self.tracklayer.isHidden = false
                self.startloader()
                Dataservices.ds.home.child("\(self.expensetype)").child(self.officeroomid).child("records").queryOrdered(byChild: "createdon").queryStarting(atValue: stp).queryEnding(atValue: etp).observeSingleEvent(of: .value) { (snap) in
                    if let ss = snap.value as? Dictionary<String,Any> {
                        for ee in ss {
                            if let each = ee.value as? Dictionary<String,Any> {
                                var addedby : String = ""
                                var amount : Int = 0
                                var createdon : Int64 = 0
                                var mode : String = ""
                                var subject : String = ""
                                
                                if let s = each["addedby"] as? String {
                                    addedby = s
                                }
                                if let s = each["amount"] as? Int {
                                    amount = s
                                }
                                if let s = each["createdon"] as? Int64 {
                                    createdon = s
                                }
                                if let s = each["mode"] as? String {
                                    mode = s
                                }
                                if let s = each["subject"] as? String {
                                    subject = s
                                }
                                
                                var x = officeexpenserecord(addedby: addedby, amount: amount, createdon: createdon, mode: mode, subject: subject)
                                self.allrecords.append(x)
                            }
                        }
                        if self.allrecords.count == 0 {
                            self.nodata.isHidden = false
                        }
                        else {
                            self.nodata.isHidden = true
                        }
                        self.shapelayer.isHidden = true
                        self.tracklayer.isHidden = true
                        self.table.reloadData()
                    }
                    else {
                        self.shapelayer.isHidden = true
                        self.tracklayer.isHidden = true
                    }
                }

                
            }
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allrecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "officeexpense", for: indexPath) as? OfficeexpensesindetailsTableViewCell {
            cell.update(x : self.allrecords[indexPath.row] , y : self.expensetype)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
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
