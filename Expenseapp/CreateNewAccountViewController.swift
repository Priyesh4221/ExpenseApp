//
//  CreateNewAccountViewController.swift
//  Expenseapp
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class CreateNewAccountViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var createanaccountlabel: UILabel!
    
    
    @IBOutlet weak var mobilenumberlabel: UILabel!
    
    @IBOutlet weak var mobileouterview: UIView!
    
    
    @IBOutlet weak var countrycodebtn: UIButton!
    
    @IBOutlet weak var mobilenumbertextfield: UITextField!
    

    @IBOutlet weak var profileouterviewtopspace: NSLayoutConstraint!
    
    
    
    
    
    @IBOutlet weak var passwordview: UIView!
    
    @IBOutlet weak var passwordfield: UITextField!
    
    @IBOutlet weak var confirmpasswordfield: UITextField!
    
    
    @IBOutlet weak var finalcreateaccbtn: UIButton!
    @IBOutlet weak var otpstatement: UILabel!
    
    
    @IBOutlet weak var otptextfieldstackview: UIStackView!
    
    
    @IBOutlet weak var nameouterview: UIView!
    
    @IBOutlet weak var namefield: UITextField!
    
    
    @IBOutlet weak var tf1: UITextField!
    
    @IBOutlet weak var tf2: UITextField!
    
    
    @IBOutlet weak var tf3: UITextField!
    
    @IBOutlet weak var tf4: UITextField!
    
    @IBOutlet weak var tf5: UITextField!
    
    
    @IBOutlet weak var tf6: UITextField!
    
    
    @IBOutlet weak var verifybtn: UIButton!
    
    
    @IBOutlet weak var namelabel: UILabel!
    
    
    @IBOutlet weak var emaillabel: UILabel!
    
    
    @IBOutlet weak var currencylabel: UILabel!
    
    
    @IBOutlet weak var genderlabel: UILabel!
    
    
    @IBOutlet weak var emailouterview: UIView!
    
    
    @IBOutlet weak var emailfield: UITextField!
    
    
    @IBOutlet weak var currencybtn: UIButton!
    
    
    @IBOutlet weak var genderbtn: UIButton!
    
    
    @IBOutlet weak var profileouterview: UIView!
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var createaccountbtn: UIButton!
    
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    var bu : basicuser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordview.isHidden = true
        self.verifybtn.layer.cornerRadius = self.verifybtn.frame.size.height/2
        self.createaccountbtn.layer.cornerRadius = self.createaccountbtn.frame.size.height/2
        self.finalcreateaccbtn.layer.cornerRadius = self.finalcreateaccbtn.frame.size.height/2
        self.profileouterview.layer.cornerRadius = self.profileouterview.frame.size.height/2
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        
        profileouterview.layer.borderWidth = 2
        profileouterview.layer.borderColor = #colorLiteral(red: 0.645892024, green: 0.5023989677, blue: 0.2323710024, alpha: 1)
        
        
        mobilenumbertextfield.delegate = self
        namefield.delegate = self
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        tf5.delegate = self
        tf6.delegate = self
        emailfield.delegate = self
        passwordfield.delegate = self
        confirmpasswordfield.delegate = self
        namefield.delegate = self
        
        
        self.backbtn.tintColor = #colorLiteral(red: 0.645892024, green: 0.5023989677, blue: 0.2323710024, alpha: 1)
        if let myImage = UIImage(named: "backpdf") {
                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                   self.backbtn.setImage(tintableImage, for: .normal)
               }
        
        
        
        self.profileimage.tintColor = #colorLiteral(red: 0.645892024, green: 0.5023989677, blue: 0.2323710024, alpha: 1)
        if let myImage = UIImage(named: "user") {
                   let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.profileimage.image = tintableImage
               }
        
        
        
        paintborder(x: mobilenumbertextfield)
        paintborder(x: passwordfield)
        paintborder(x: confirmpasswordfield)
        paintborder(x: namefield)
        paintborder(x: tf1)
        paintborder(x: tf2)
        paintborder(x: tf3)
        paintborder(x: tf4)
        paintborder(x: tf5)
        paintborder(x: tf6)
        paintborder(x: emailfield)
        
        self.countrycodebtn.backgroundColor = #colorLiteral(red: 0.645892024, green: 0.5023989677, blue: 0.2323710024, alpha: 1)
        self.countrycodebtn.setTitleColor(UIColor.white, for: .normal)
        self.countrycodebtn.layer.cornerRadius = 5
        
        
        prepareinitial()

        // Do any additional setup after loading the view.
    }
    
    
    func paintborder(x : UITextField)
    {
        x.layer.borderWidth = 1
        x.layer.borderColor = #colorLiteral(red: 0.645892024, green: 0.5023989677, blue: 0.2323710024, alpha: 1)
        x.layer.cornerRadius = 5
        x.font = UIFont.init(name: "Optima", size: 18)
        
    }
    
    
    func prepareinitial()
    {
        self.otpstatement.isHidden = true
        self.otptextfieldstackview.isHidden = true
        self.verifybtn.isHidden = true
        self.profileouterview.isHidden = true
        self.namelabel.isHidden = true
        self.nameouterview.isHidden = true
        self.emaillabel.isHidden = true
        self.emailfield.isHidden = true
        self.currencylabel.isHidden = true
        self.currencybtn.isHidden = true
        self.genderbtn.isHidden = true
        self.genderlabel.isHidden = true
        self.createaccountbtn.isHidden = true
    }
    
    
    @IBAction func countrycodetapped(_ sender: Any) {
    }
    
    
    @IBAction func verifybtntapped(_ sender: Any) {
        
        
        
        var x = self.mobilenumberlabel.frame.origin.y
               var y = self.profileouterview.frame.origin.y
               
               var z = x - y + 32
            self.profileouterviewtopspace.constant = z
               
        self.bu?.mobile = self.mobilenumbertextfield.text ?? ""
        self.bu?.countrycode = self.countrycodebtn.titleLabel?.text ?? ""
               
               
               self.otpstatement.isHidden = true
               self.otptextfieldstackview.isHidden = true
               self.mobilenumberlabel.isHidden = true
               self.mobileouterview.isHidden = true
               self.verifybtn.isHidden = true
               self.profileouterview.isHidden = false
               self.namelabel.isHidden = false
               self.nameouterview.isHidden = false
               self.emaillabel.isHidden = false
               self.emailfield.isHidden = false
               self.currencylabel.isHidden = false
               self.currencybtn.isHidden = false
               self.genderbtn.isHidden = false
               self.genderlabel.isHidden = false
               self.createaccountbtn.isHidden = false
        
        
        
        
        
       
    }
    
    
    @IBAction func createaccounttapped(_ sender: Any) {
        if let m = mobilenumbertextfield.text as? String {
            if let name = namefield.text as? String {
                if let email = emailfield.text as? String {
                    if m == "" || m == " " || name == "" || name == " " || email == "" || email == " " {
                        
                    }
                    else {
                        bu?.name = name
                        bu?.email = email
                        bu?.currency = currencybtn.titleLabel?.text ?? ""
                        bu?.gender = genderbtn.titleLabel?.text ?? ""
                        self.profileouterview.isHidden = true
                        self.namelabel.isHidden = true
                        self.verifybtn.isHidden = true
                        self.nameouterview.isHidden = true
                        self.emaillabel.isHidden = true
                        self.emailfield.isHidden = true
                        self.currencylabel.isHidden = true
                        self.currencybtn.isHidden = true
                        self.genderbtn.isHidden = true
                        self.genderlabel.isHidden = true
                        self.createaccountbtn.isHidden = true
                        self.passwordview.isHidden = false
                        
                        
                    }
                }
            }
        }
    }
    
    @IBAction func finalcreateaccnttapped(_ sender: Any) {
        if let p = self.passwordfield.text as? String {
            if let cp = self.confirmpasswordfield.text as? String {
                print(p)
                print(cp)
                print(bu?.email ?? "")
                if p == "" || p == " " {
                    
                }
                else {
                    if p == cp {
                        if let em = emailfield.text as? String {
                            FIRAuth.auth()?.createUser(withEmail: em, password: p, completion: { (user, err) in
                                if err == nil {
                                    self.bu?.userid = user?.uid ?? ""
                                    user?.sendEmailVerification(completion: { (err) in
                                        if err == nil {
                                             self.bu = basicuser(userid: user?.uid ?? "", name: self.namefield.text ?? "", email: self.emailfield.text ?? "", countrycode: self.countrycodebtn.titleLabel?.text ?? "", mobile: self.mobilenumbertextfield.text ?? "", currency: self.currencybtn.titleLabel?.text ?? "", gender: self.genderbtn.titleLabel?.text ?? "", profileimageurl: "")
                                            var d : Dictionary<String,Any> = ["currency" : self.bu?.currency ?? "" ,"email" : self.bu?.email , "gender" : self.bu?.gender ?? "" , "mobile" : self.bu?.mobile ?? "", "name" : self.bu?.name ?? "" , "plan" : "basic","profileimage" : "" , "status" : "active"]
                                            var e : Dictionary<String,Any> = ["unseennotificationscount" : 0 , "basic" : d]
                                            Dataservices.ds.users.child(user?.uid ?? "").setValue(e) { (err, ref) in
                                                if err == nil {
                                                    Dataservices.ds.home.child("appusers").child(self.bu?.mobile ?? "").setValue(user?.uid ?? "") { (errapp, refapp) in
                                                        if errapp == nil {
                                                            self.present(Customalert.cs.showalert(x: "Profile Created", y: ""), animated: true, completion: nil)
                                                            if let u = KeychainWrapper.standard.string(forKey: "auth") as? String {
                                                                if #available(iOS 13.0, *) {
                                                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CustomTabBarViewController") as! CustomTabBarViewController
                                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                                } else {
                                                                    // Fallback on earlier versions
                                                                    let vc = CustomTabBarViewController()
                                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                                }
                                                            }

//                                                            self.performSegue(withIdentifier: "enterhome", sender: nil)
                                                        }
                                                    }
                                                    
                                                   
                                                }
                                            }
                                        }
                                    })
                                    
                                }
                                else {
                                    if let s = (err?.localizedDescription) as? String {
                                        self.present(Customalert.cs.showalert(x: "\(s)", y: ""), animated: true, completion: nil)
                                    }
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func currencybtntapped(_ sender: Any) {
    }
    
    
    @IBAction func genderbtntapped(_ sender: Any) {
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 51 {
            if self.mobilenumbertextfield.text?.count == 10 {
//                self.otpstatement.isHidden = false
//                self.otptextfieldstackview.isHidden = false
                self.verifybtn.isHidden = false
                self.mobilenumbertextfield.isEnabled = false
            }
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mobilenumbertextfield.resignFirstResponder()
        namefield.resignFirstResponder()
        tf1.resignFirstResponder()
        tf2.resignFirstResponder()
        tf3.resignFirstResponder()
        tf4.resignFirstResponder()
        tf5.resignFirstResponder()
        tf6.resignFirstResponder()
        emailfield.resignFirstResponder()
        passwordfield.resignFirstResponder()
        confirmpasswordfield.resignFirstResponder()
        namefield.resignFirstResponder()
        return true
    }
    
    
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
