//
//  LoginViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/31/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import UIKit
import Firebase
import  SwiftKeychainWrapper

class LoginViewController: UIViewController , CAAnimationDelegate , UITextFieldDelegate{

    
    
    @IBOutlet weak var overlayinner: UIView!
    @IBOutlet weak var overlayview: UIView!
    
    @IBOutlet weak var logoimageview: UIImageView!
    
    var mask : CALayer!
    var basicanimation : CABasicAnimation!
    
    @IBOutlet weak var email: CustomTextField!
    
    @IBOutlet weak var password: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        setupcolors()
        email.delegate = self
        password.delegate = self

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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
    func setupcolors()
    {
        
//        self.overlayview.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        self.overlayview.backgroundColor = UIColor.black
    }
    
    
    
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
           tracklayer.strokeColor = hexStringToUIColor(hex: Theme.theme.getprimary()).cgColor
           tracklayer.lineWidth = 6
           self.view.layer.insertSublayer(tracklayer, at: 10)
           
           shapelayer.path = circularpath.cgPath
           shapelayer.fillColor = UIColor.clear.cgColor
           
           shapelayer.strokeEnd = 0
           shapelayer.lineCap = kCALineCapRound
           shapelayer.strokeColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
           shapelayer.lineWidth = 6
           shapelayer.opacity = 0.8
           shapelayer.shadowColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
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
    
    
    func stoploader()
    {
        self.shapelayer.isHidden = true
        self.tracklayer.isHidden = true
        self.shapelayer.removeAllAnimations()
    }
    
    
    @IBAction func loginpressed(_ sender: UIButton) {
        
        
        
        if let e = self.email.text , let p = self.password.text
        {
            self.startloader()
            FIRAuth.auth()?.signIn(withEmail: e, password: p, completion: { (user, err) in
                if (err != nil)
                {
                    self.present(Customalert.cs.showalert(x: "User not found", y: ""), animated: true, completion: nil)
                    print("User does not exist")
                    self.stoploader()
                }
                else
                {
                    if user?.isEmailVerified ?? false {
                        if let k = user?.uid
                        {
                            KeychainWrapper.standard.set(k, forKey: "auth")
                            print("user exist with id \(k)")
                            self.stoploader()
                            if #available(iOS 13.0, *) {
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CustomTabBarViewController") as! CustomTabBarViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                // Fallback on earlier versions
                                let vc = CustomTabBarViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        }
                    }
                    else {
                        self.stoploader()
                        let alert = UIAlertController(title: "Email not verified", message: "Kindly confirm your email by clicking on the link received on your email.",preferredStyle: UIAlertControllerStyle.alert)
                        alert.modifyalertview()
                        
                        alert.addAction(UIAlertAction(title: "Resend Email Verification", style: UIAlertActionStyle.default, handler: { _ in
                            //Cancel Action
                            user?.sendEmailVerification(completion: { (err) in
                                
                            })
                        }))
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { _ in
                            //Cancel Action
                        }))
                        self.present(alert, animated: true) {
                            
                        }
                    }
                    
                }
            })
        }
    }
    
    
    @IBAction func loginwithfacebookpressed(_ sender: UIButton) {
    }
    
    
    @IBAction func createanaccountpressed(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "signup") as! CreateNewAccountViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = CreateNewAccountViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
//        self.performSegue(withIdentifier: "createacc", sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
//        setupmask()
    }
    
    
    func setupmask()
    {
        
        mask = CALayer()
        mask.contents = logoimageview.image?.cgImage
        mask.bounds = CGRect(x: 0, y: 0, width: self.overlayview.frame.size.width, height: self.overlayview.frame.size.height)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        
        
        self.overlayview.layer.mask = mask
        decreaseoverlay()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        increaseoverlay()
    }
    
    func decreaseoverlay()
    {
        let increasesize = CABasicAnimation(keyPath: "bounds")
        let time = 0.3
        increasesize.delegate = self
        increasesize.duration = time
        increasesize.beginTime = CACurrentMediaTime() + 2.0
        increasesize.fromValue = NSValue(cgRect: mask!.bounds)
        increasesize.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 180, height: 180))
        
        increasesize.fillMode = kCAFillModeForwards
        increasesize.isRemovedOnCompletion = false
        
        mask.add(increasesize, forKey: "bounds")
    }
    
    func increaseoverlay()
    {
        basicanimation = CABasicAnimation(keyPath: "bounds")
        let time = 0.8
        basicanimation.delegate = self
        basicanimation.duration = time
        basicanimation.beginTime = CACurrentMediaTime() + 5.0
        basicanimation.fromValue = NSValue(cgRect: mask!.bounds)
        basicanimation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1200, height: 1200))
        
        basicanimation.fillMode = kCAFillModeForwards
        basicanimation.isRemovedOnCompletion = false
        
        mask.add(basicanimation, forKey: "bounds")
        
        UIView.animate(withDuration: time) {
            self.logoimageview.bounds.size.width = 4000
            self.logoimageview.bounds.size.height = 4000
            self.overlayview.alpha = 0
        }
        
        UIView.animate(withDuration: 2*time) {
         
            self.overlayview.alpha = 0
        }
        
        
       
        
        
        
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
