//
//  ChooseRankViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/26/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit

class ChooseRankViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    
    var splitamong = [user]()
    var rankeduser = Dictionary<Int , user>()
    var ongoingrank = 1
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var summaryheading: UILabel!
    @IBOutlet weak var summarybtnarrow: UIButton!
    @IBOutlet weak var summarymode: UILabel!
    @IBOutlet weak var summaryduration: UILabel!
    @IBOutlet weak var summaryrate: UILabel!
    @IBOutlet weak var summarymembers: UILabel!
    
    @IBOutlet weak var totalamount: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var backbtnlower: UIButton!
    
    @IBOutlet weak var nextbtnlower: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var ranklabel: UILabel!
    
    
    var billtransaction : billsplittransaction?
    
    
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
        
        
        self.ranklabel.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.summaryheading.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.summarymode.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.summaryduration.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.summaryrate.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.summarymembers.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.totalamount.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.desc.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
         self.summarybtnarrow.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.backbtnlower.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
     
        self.backbtnlower.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        self.nextbtnlower.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
        self.nextbtnlower.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.nextbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate = self
        self.collection.dataSource = self
        self.fetchdata()
        

        // Do any additional setup after loading the view.
    }
    
    func fetchdata()
    {
        for contact in (self.billtransaction?.receipients)!
        {
//            var x = user(name: contact.name, id: contact.id, selected: contact.selected)
//            self.splitamong.append(x)
        }
        
       print(self.billtransaction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.splitamong.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooserank", for: indexPath) as? ChooseRankCollectionViewCell
        {
            cell.updatecell(x: self.splitamong[indexPath.row].name)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var s = CGSize(width: self.collection.frame.width/2.1, height: self.collection.frame.width/2.1)
        return s
        
    }
    
    
    @IBAction func nextbtnpressed(_ sender: UIButton) {
        if self.ongoingrank < self.splitamong.count
        {
            self.ongoingrank = self.ongoingrank + 1
            self.ranklabel.text = "Tap Rank \(self.ongoingrank)"
        }
    }
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        if self.ongoingrank > 1
        {
            self.ongoingrank = self.ongoingrank - 1
            self.ranklabel.text = "Tap Rank \(self.ongoingrank)"
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
