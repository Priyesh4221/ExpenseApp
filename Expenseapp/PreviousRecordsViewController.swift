//
//  PreviousRecordsViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 11/5/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit



class PreviousRecordsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var lowerfilterbutton: UIButton!
    
    var records = [PreviousRecord]()
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
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
        
       self.segment.tintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
               self.segment.backgroundColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
               
               let titleTextAttributes = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimaryfont()) ]
               let titleTextAttributes2 = [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: Theme.theme.getprimary()) ]
                segment.setTitleTextAttributes(titleTextAttributes2, for: .normal)
               segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
              
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.addbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.lowerfilterbutton.backgroundColor = hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.lowerfilterbutton.setTitleColor(hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate = self
        self.collection.dataSource = self
        self.fetchdata()

        // Do any additional setup after loading the view.
    }
    func fetchdata()
    {
        var x  = PreviousRecord(amount: 500, date: "27/08/2018", purpose: "Pizza")
        var y = PreviousRecord(amount: 1000, date: "02/03/2018", purpose: "Outing")
        self.records.append(x)
        self.records.append(y)
        self.records.append(x)
        self.records.append(y)
        self.records.append(x)
        self.records.append(y)
        self.records.append(x)
        self.records.append(y)
        self.records.append(x)
        self.records.append(y)
        self.records.append(x)
        self.records.append(y)
        self.collection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previousrecordcell", for: indexPath) as? PreviousRecordsCollectionViewCell
        {
            cell.updatecell(x: self.records[indexPath.row].amount, y: self.records[indexPath.row].date, z: self.records[indexPath.row].purpose)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width ,height : 90)
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
