//
//  ProfileViewController.swift
//  Expenseapp
//
//  Created by admin on 10/09/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var editorviewbottomspace: NSLayoutConstraint!
    
    @IBOutlet weak var gendercurrencyview: UIStackView!
    @IBOutlet weak var editorview: UIView!
    
    @IBOutlet weak var closeeidtobtn: UIButton!
    
    @IBOutlet weak var editorhead: UILabel!
    
    
    @IBOutlet weak var camerabtn: UIButton!
    
    
    @IBOutlet weak var gallerybtn: UIButton!
    
    
    @IBOutlet weak var namelabel: UILabel!
    
    
    @IBOutlet weak var namefield: UITextField!
    
    
    @IBOutlet weak var genderlabel: UILabel!
    
    
    @IBOutlet weak var currencylabel: UILabel!
    
    
    @IBOutlet weak var genderbtn: UIButton!
    
    @IBOutlet weak var currencybtn: UIButton!
    
    
    @IBOutlet weak var updatebtn: UIButton!
    
    @IBOutlet weak var nametopspace: NSLayoutConstraint!
    
    @IBOutlet weak var photoview: UIStackView!
    
    
    @IBOutlet weak var selectedimage: UIImageView!
    
    
    
    
    @IBOutlet weak var upperview: UIView!
    
    
    @IBOutlet weak var editbutton: UIButton!
    
    
    @IBOutlet weak var logoutbutton: UIButton!
    
    @IBOutlet weak var imageouterview: UIView!
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var emailhead: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var mobilehead: UILabel!
    
    
    @IBOutlet weak var mobile: UILabel!
    
    
    @IBOutlet weak var genderhead: UILabel!
    
    
    
    @IBOutlet weak var gender: UILabel!
    
    
    @IBOutlet weak var currencyhead: UILabel!
    
    
    @IBOutlet weak var currency: UILabel!
    
    
    @IBOutlet weak var accounthead: UILabel!
    
    
    @IBOutlet weak var account: UILabel!
    
    
    @IBOutlet weak var planhead: UILabel!
    
    
    @IBOutlet weak var plan: UILabel!
    
    
    @IBOutlet weak var upgradebtn: UIButton!
    
    var currentuser : profileuser?
    
    var editormode = "picture"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageouterview.layer.cornerRadius = 10
        self.upgradebtn.layer.cornerRadius = 5
        self.editorviewbottomspace.constant = 400
        self.updatebtn.layer.cornerRadius = 10
        self.genderbtn.layer.cornerRadius = 5
        self.currencybtn.layer.cornerRadius = 5
        self.editorview.layer.cornerRadius = 10
        
        self.setupcolors()
        self.fetchprofile()
        

        // Do any additional setup after loading the view.
    }
    
    
    func prepareeditorview()
    {
        if self.editormode == "picture" {
            self.editorhead.text = "Change Profile Picture"
            self.photoview.isHidden = false
            self.selectedimage.isHidden = false
            self.namelabel.isHidden = true
            self.namefield.isHidden = true
            self.gendercurrencyview.isHidden = true
            self.nametopspace.constant = 16
        }
        else {
            self.editorhead.text = "Update Profile"
            self.photoview.isHidden = true
            self.selectedimage.isHidden = true
            self.namelabel.isHidden = false
            self.namefield.isHidden = false
            self.gendercurrencyview.isHidden = false
            self.nametopspace.constant = -32
        }
        
        UIView.animate(withDuration: 1) {
            self.editorviewbottomspace.constant = -400
        }
        
    }
    
    
    
    func setupcolors()
    {
        self.view.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.upperview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.editbutton.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.logoutbutton.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.imageouterview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.profilename.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.emailhead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.email.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.mobilehead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.mobile.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.genderhead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.gender.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.currencyhead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.currency.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.accounthead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.account.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.planhead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.plan.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.upgradebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.upgradebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.editorview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.editorhead.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.namelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.namefield.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.namefield.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.genderlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.currencylabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.genderbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.currencybtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        self.genderbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.currencybtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.updatebtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.updatebtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        
        self.selectedimage.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
        self.selectedimage.layer.cornerRadius = 10
        self.selectedimage.layer.borderWidth = 2
        
        self.profileimage.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())

        if let myImage = UIImage(named: "user") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.profileimage.image = tintableImage
        }
        
        
        self.closeeidtobtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())

        if let myImage = UIImage(named: "close") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            self.closeeidtobtn.setImage(tintableImage, for: .normal)
        }
        
        self.camerabtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())

        if let myImage = UIImage(named: "camera") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            
            self.camerabtn.setImage(tintableImage, for: .normal)
        }
        
        self.gallerybtn.tintColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())

        if let myImage = UIImage(named: "gallery") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            
            self.gallerybtn.setImage(tintableImage, for: .normal)
        }
        
        
        
        
    }
    
    
    
    func fetchprofile()
    {
        var userid = KeychainWrapper.standard.string(forKey: "auth")!
        userid = "xytsha3527383"
        Dataservices.ds.users.child(userid).child("basic").observeSingleEvent(of: .value) { (snappy) in
            if let sn = snappy.value as? Dictionary<String,Any> {
                var name = ""
                var email = ""
                var mobile = ""
                var gender = ""
                var currency = ""
                var countrycode = ""
                var account = ""
                var plan = ""
                var profileimage = ""
                
                if let e = sn["name"] as? String {
                    name = e
                }
                if let e = sn["currency"] as? String {
                    currency = e
                }

                if let e = sn["email"] as? String {
                    email = e
                }

                if let e = sn["gender"] as? String {
                    if e.lowercased() == "m" {
                        gender = "Male"
                    }
                    else if e.lowercased() == "f" {
                        gender = "Female"
                    }
                    else {
                        gender = e
                    }
                }

                if let e = sn["mobile"] as? String {
                    mobile = e
                }

                if let e = sn["plan"] as? String {
                    plan = e
                }

                if let e = sn["profileimage"] as? String {
                    profileimage = e
                }

                if let e = sn["status"] as? String {
                    account = e
                }

                self.currentuser = profileuser(userid: userid, name: name, email: email, mobile: mobile, countrycode: "", gender: gender, currency: currency, account: account, plan: plan, profileimage: profileimage)
                self.feedvalues()
            }
        }
    }
    
    
    
    func feedvalues()
    {
        self.profilename.text = self.currentuser?.name.capitalized ?? ""
        self.email.text = self.currentuser?.email ?? ""
        self.mobile.text = self.currentuser?.mobile ?? ""
        self.gender.text = self.currentuser?.gender.capitalized ?? ""
        self.currency.text = self.currentuser?.currency.capitalized ?? ""
        self.account.text = self.currentuser?.account.capitalized ?? ""
        self.plan.text = self.currentuser?.plan.capitalized ?? ""
        
        self.namefield.text = self.currentuser?.name.capitalized ?? ""
        self.currencybtn.setTitle(self.currentuser?.currency.capitalized ?? "", for: .normal)
        self.genderbtn.setTitle(self.currentuser?.gender.capitalized ?? "", for: .normal)
    }
    
    
    @IBAction func closeeditviewpressed(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.editorviewbottomspace.constant = 400
        }
    }
    
    
    @IBAction func camerapressed(_ sender: Any) {
    }
    
    
    @IBAction func gallerypressed(_ sender: Any) {
    }
    
    @IBAction func genderpressed(_ sender: Any) {
    }
    
    
    @IBAction func currencypressed(_ sender: Any) {
    }
    
    
    @IBAction func updatepressed(_ sender: Any) {
    }
    
    
    @IBAction func editpressed(_ sender: Any) {
        editormode = "profile"
        self.prepareeditorview()
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
