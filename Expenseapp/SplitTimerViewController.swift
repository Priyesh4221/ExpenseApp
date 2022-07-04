//
//  SplitTimerViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/25/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class SplitTimerViewController: UIViewController {

    
    @IBOutlet weak var navbar: UIView!
    
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    
    @IBOutlet weak var note1: UILabel!
    
    @IBOutlet weak var note2: UILabel!
    
    
    @IBOutlet weak var note3: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var starttimerbtn: Custombtn!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var footerbtn: UIButton!
    
    
    
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
        
       
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.note1.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.note2.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.note3.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.time.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
   
        
        
        
        
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        self.starttimerbtn.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.starttimerbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        
        self.footerbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.footerbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    var billtransaction : billsplittransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.note1.text = "Mode : \(self.billtransaction?.mode?.capitalized)"
        self.note2.text = "Rate : Rs \(self.billtransaction?.rate) per min"
        self.note3.text = "Split among \(self.billtransaction?.receipients?.count) person"

        // Do any additional setup after loading the view.
    }

    
    @IBAction func starttimerpressed(_ sender: UIButton) {
        if starttimerbtn.titleLabel?.text == "START TIMER"
        {
            self.starttimerbtn.titleLabel?.text = "PAUSE TIMER"
            self.nextbtn.isEnabled = false
            starttimer()
            
        }
        else{
            self.starttimerbtn.titleLabel?.text = "START TIMER"
            self.nextbtn.isEnabled = true
            stoptimer()
        }
        
    }
    
    func starttimer()
    {
        
    }
    
    func stoptimer()
    {
        
    }
    
    
    @IBAction func stopbtnpressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toresults", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let seg = segue.destination as? ChooseRankViewController
            {
                seg.billtransaction = self.billtransaction
            }
    }
    

}
