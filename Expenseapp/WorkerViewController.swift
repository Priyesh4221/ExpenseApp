//
//  WorkerViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController {

    var selectedcategory = ""
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    
    @IBOutlet weak var teachername: UILabel!
    
    @IBOutlet weak var teachernamevalue: CustomTextField!
    
    @IBOutlet weak var paymentrate: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    @IBOutlet weak var switchcv: Customswitch!
    
    
    @IBOutlet weak var reqcvlabel: UILabel!
    
    
    @IBOutlet weak var useridlabel: UILabel!
    
    @IBOutlet weak var useridvalue: CustomTextField!
    
    @IBOutlet weak var helponuserid: UIButton!
    
    @IBOutlet weak var footerdescription: UILabel!
    
    
    
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
        
        
        
        self.teachername.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.paymentrate.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.reqcvlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useridlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
         self.teachernamevalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.teachernamevalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.useridvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useridvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        
         self.segment.tintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
               self.segment.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               
               let titleTextAttributes = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
               let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimary()) ]
                segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
               segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
              
        
        
        self.switchcv.bordercolor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.switchcv.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.switchcv.onTintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
       
        
        
        self.helponuserid.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        self.footerdescription.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.footerdescription.textColor =  hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gonext(_ sender: UIButton) {
        if selectedcategory == "teacher"
        {
            performSegue(withIdentifier: "teacher2", sender: nil)
        }
        else if selectedcategory == "worker"
        {
            performSegue(withIdentifier: "worker2", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedcategory == "teacher"
        {
            navbarhead.text = "TEACHER"
            teachername.text = "Teacher name"
        }
        else if selectedcategory == "worker"
        {
            navbarhead.text = "WORKER"
            teachername.text = "Worker name"
        }
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
