//
//  SubjectsConfirmationViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/15/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit



class SubjectsConfirmationViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
  
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var subjects: UILabel!
    
    @IBOutlet weak var lowerconfirmbtn: UIButton!
    
    var subjectdetails = [subjectdetail]()
    
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
        
        
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.name.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.subjects.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.lowerconfirmbtn.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.lowerconfirmbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
        self.fetchdata()

        // Do any additional setup after loading the view.
    }
    
    
    func fetchdata()
    {
        var x = subjectdetail(subjectname: "Maths", feesmode: "Monthly", feesamount: 2000, noofclasses: 12)
        var y = subjectdetail(subjectname: "English", feesmode: "Day", feesamount: 500, noofclasses: 12)
        self.subjectdetails.append(x)
         self.subjectdetails.append(y)
        self.subjectdetails.append(x)
        self.subjectdetails.append(y)
        self.subjectdetails.append(x)
        self.subjectdetails.append(y)
        self.collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjectdetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectconfirm", for: indexPath) as? SubjectsConfirmationCollectionViewCell
        {
            cell.updatecell(x: self.subjectdetails[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
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
