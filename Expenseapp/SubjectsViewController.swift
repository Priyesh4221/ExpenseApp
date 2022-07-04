//
//  SubjectsViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/3/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class SubjectsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
   
    var subjects = 2
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    
    
    @IBOutlet weak var loweraddbtn: UIButton!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
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
        
        self.loweraddbtn.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.loweraddbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
    }
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate = self
        self.collection.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cofirm(_ sender: UIButton) {
        performSegue(withIdentifier: "subjectsconfirm", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects
    }
    
    @IBAction func addbtnpressed(_ sender: UIButton) {
        
        for item in 0..<subjects {
           if let c =   self.collection.cellForItem(at: IndexPath(row: item, section: 0)) as? SubjectsCollectionViewCell
            {
                c.displaycell()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "subjectcell", for: indexPath) as? SubjectsCollectionViewCell
        {
            cell.updatecell(x: indexPath.row + 1)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width ,height : 400)
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
