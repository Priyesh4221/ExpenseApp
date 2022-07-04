//
//  SplitEquallyViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/24/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit

class SplitEquallyViewController: UIViewController , UITextFieldDelegate {
    
    var state = ""
    var billtransaction : billsplittransaction?

    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var note2: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var amountlabel: UILabel!
    
    @IBOutlet weak var amountvalue: CustomTextField!
    
    @IBOutlet weak var commentlabel: UILabel!
    
    @IBOutlet weak var commentvalue: CustomTextField!
    
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountvalue.resignFirstResponder()
        commentvalue.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountvalue.resignFirstResponder()
        commentvalue.resignFirstResponder()
    }
    
    
    func setupcolors()
    {
        self.navbar.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.scrollview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getprimary())
        
         self.segment.tintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
               self.segment.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               
               let titleTextAttributes = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
               let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimary()) ]
                segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
               segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
              
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.note.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.note2.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amountlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.commentlabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.amountvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amountvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.amountvalue.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.commentvalue.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.commentvalue.layer.borderColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
        self.commentvalue.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
        
        
        
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.footerbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.footerbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         segment.addTarget(self, action: #selector(self.segmentedValueChanged), for: .valueChanged)
        
        if self.state == "equal"
        {
            self.navbarhead.text = "Split Equally"
        }else if self.state == "ratio"
        {
            self.navbarhead.text = "Split In Ratio"
        }else if self.state == "game"
        {
            self.navbarhead.text = "Game Split"
        }
        amountvalue.delegate = self
        commentvalue.delegate = self
        
        self.addbtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "backpdf") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.addbtn.setImage(tintableImage, for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    

    @objc func segmentedValueChanged()
    {
        if segment.selectedSegmentIndex == 0
        {
            self.amountlabel.text = "Amount"
        }
        else
        {
            self.amountlabel.text = "Rate per minute"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func gonext(_ sender: UIButton) {
        if let am = Int(self.amountvalue.text ?? "0") as? Int
        {
            if am > 0 {
                
                if #available(iOS 13.0, *) {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "spam") as! SplitAmongViewController
                    vc.state = self.state
                               if segment.selectedSegmentIndex == 0
                               {
                                   vc.mode = "fixed"
                                   self.billtransaction?.mode = "fixed"
                               }
                               else if segment.selectedSegmentIndex == 1
                               {
                                   vc.mode = "timer"
                                   self.billtransaction?.mode = "timer"
                               }
                               if vc.mode == "fixed"
                               {
                                   print(self.amountvalue.text)
                                   if let am = Int(self.amountvalue.text ?? "0") as? Int
                                   {
                                       self.billtransaction?.amount = Double(am)
                                   }
                                   print(self.billtransaction?.amount)
                               }
                               else if vc.mode == "timer"
                               {
                                   if let rt = self.amountvalue.text as? Double
                                   {
                                       self.billtransaction?.rate = rt
                                   }
                               }
                                   self.billtransaction?.comment = self.commentvalue.text
                                   vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    // Fallback on earlier versions
                    let vc = SplitAmongViewController()
                    vc.state = self.state
                    if segment.selectedSegmentIndex == 0
                    {
                        vc.mode = "fixed"
                        self.billtransaction?.mode = "fixed"
                    }
                    else if segment.selectedSegmentIndex == 1
                    {
                        vc.mode = "timer"
                        self.billtransaction?.mode = "timer"
                    }
                    if vc.mode == "fixed"
                    {
                        print(self.amountvalue.text)
                        if let am = Int(self.amountvalue.text ?? "0") as? Int
                        {
                            self.billtransaction?.amount = Double(am)
                        }
                        print(self.billtransaction?.amount)
                    }
                    else if vc.mode == "timer"
                    {
                        if let rt = self.amountvalue.text as? Double
                        {
                            self.billtransaction?.rate = rt
                        }
                    }
                        self.billtransaction?.comment = self.commentvalue.text
                        vc.billtransaction = self.billtransaction
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
//                performSegue(withIdentifier: "splitamong", sender: nil)

            }
            else {
                self.present(Customalert.cs.showalert(x: "Amount Invalid", y: "Bill amount should be greater than 0."), animated: true, completion: nil)

            }
        }
        
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let seg = segue.destination as? SplitAmongViewController
         {
            seg.state = self.state
            if segment.selectedSegmentIndex == 0
            {
                seg.mode = "fixed"
                self.billtransaction?.mode = "fixed"
            }
            else if segment.selectedSegmentIndex == 1
            {
                seg.mode = "timer"
                self.billtransaction?.mode = "timer"
            }
            if seg.mode == "fixed"
            {
                print(self.amountvalue.text)
                if let am = Int(self.amountvalue.text ?? "0") as? Int
                {
                    self.billtransaction?.amount = Double(am)
                }
                print(self.billtransaction?.amount)
            }
            else if seg.mode == "timer"
            {
                if let rt = self.amountvalue.text as? Double
                {
                    self.billtransaction?.rate = rt
                }
            }
                self.billtransaction?.comment = self.commentvalue.text
                seg.billtransaction = self.billtransaction
            
        }
    }
  

}
