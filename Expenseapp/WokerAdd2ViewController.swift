//
//  WokerAdd2ViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class WokerAdd2ViewController: UIViewController {
    
    
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    @IBOutlet weak var monthlysalarylabel: UILabel!
    
    @IBOutlet weak var monthlysalaryvalue: CustomTextField!
    
    @IBOutlet weak var monthstartfromlabel: UILabel!
    
    @IBOutlet weak var monthstartfromvalue: CustomTextField!
    
    @IBOutlet weak var durationlabel: UILabel!
    
    @IBOutlet weak var durationvalue: CustomTextField!
    
    @IBOutlet weak var salarylabel: UILabel!
    
    @IBOutlet weak var salaryvalue: CustomTextField!
    
    @IBOutlet weak var footerdesc: UILabel!
    
    @IBOutlet weak var helponuseridlabel: UIButton!
    
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
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        self.monthlysalarylabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.monthstartfromlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.durationlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.salarylabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.monthlysalaryvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.monthlysalaryvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.monthstartfromvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.monthstartfromvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.durationvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.durationvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.salaryvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.salaryvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
      
        
        
        
        
        
        
        
        
        
        self.helponuseridlabel.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        self.footerdesc.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.footerdesc.textColor =  hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
  
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
