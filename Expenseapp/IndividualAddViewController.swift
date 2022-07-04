//
//  IndividualAddViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class IndividualAddViewController: UIViewController {
    
    @IBOutlet weak var navbar: UIView!
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var namevalue: CustomTextField!
    
    @IBOutlet weak var switchcv: Customswitch!
    
    @IBOutlet weak var reqcvlabel: UILabel!
    
    @IBOutlet weak var useridlabel: UILabel!
    
    @IBOutlet weak var useridvalue: CustomTextField!
    
    @IBOutlet weak var helponuseridlabel: UIButton!
    
    @IBOutlet weak var footerdesc: UILabel!
    
    
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
        
        
        
        self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
       
        self.reqcvlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useridlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.namevalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.namevalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        self.useridvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.useridvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        
        
      
        
        self.switchcv.bordercolor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.switchcv.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.switchcv.onTintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        
        
        self.helponuseridlabel.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        self.footerdesc.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.footerdesc.textColor =  hexStringToUIColor(hex: Theme.theme.getsecondaryfont())
        
        
    }
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.namevalue.frame.size.height - 1, width: self.namevalue.frame.size.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        self.namevalue.layer.addSublayer(bottomBorder)
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
