//
//  ChooseSplitoptionViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class ChooseSplitoptionViewController: UIViewController {
    
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var firstoption: UIButton!
    
    @IBOutlet weak var secondoption: UIButton!
    
    @IBOutlet weak var thirdoption: UIButton!
    
    
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
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.firstoption.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
       self.firstoption.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.secondoption.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
    self.secondoption.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
       
        
        
        self.footerbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.footerbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
        
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    var state = ""
    var billtransaction : billsplittransaction?
    @IBAction func firstoptionclicked(_ sender: UIButton) {
        state = "equal"
        billtransaction =  billsplittransaction(category: "equal", comment: "", mode: "", amount: 0.0, receipients: [], billamountsgenerated: [], duration: "", rate: 0.0, ranks: [])
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "speq") as! SplitEquallyViewController
            vc.state = self.state
            vc.billtransaction = self.billtransaction
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = SplitEquallyViewController()
            vc.state = self.state
            vc.billtransaction = self.billtransaction
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        performSegue(withIdentifier: "splitequally", sender: nil)
    }
    
    
    @IBAction func secondoptionclicked(_ sender: UIButton) {
        state = "ratio"
        billtransaction =  billsplittransaction(category: "ratio", comment: "", mode: "", amount: 0.0, receipients: [],billamountsgenerated: [], duration: "", rate: 0.0, ranks: [])
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "speq") as! SplitEquallyViewController
            vc.state = self.state
            vc.billtransaction = self.billtransaction
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = SplitEquallyViewController()
            vc.state = self.state
            vc.billtransaction = self.billtransaction
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        performSegue(withIdentifier: "splitequally", sender: nil)
    }
    
//    @IBAction func thirdoptionclicked(_ sender: UIButton) {
//        state = "game"
//        billtransaction =  billsplittransaction(category: "game", comment: "", mode: "", amount: 0.0, receipients: [],billamountsgenerated: [], duration: "", rate: 0.0, ranks: [])
//        performSegue(withIdentifier: "splitequally", sender: nil)
//    }
    
    @IBAction func goback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.addbtn.setImage(tintableImage, for: .normal)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let seg = segue.destination as? SplitEquallyViewController
       {
            seg.state = self.state
        seg.billtransaction = self.billtransaction
        }
    }
    

}
