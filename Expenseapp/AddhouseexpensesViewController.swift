//
//  AddhouseexpensesViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 5/3/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class AddhouseexpensesViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
  
    
    
    
    
    var allsuggested = ["Groceries","Fruits/Vegetables","Laundry","Maid Bill","Electric Bill","Phone Bill",
                        "Gas Bill","Milk","Newspaper","Cable Bill","Broadband","Mobile recharge","Rent"]
    
    
    
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    @IBOutlet weak var footerview: UIView!
    
    
    @IBOutlet weak var backgroundimage: UIImageView!
    
    
    @IBOutlet weak var backgroundoverlay: UIView!
    
    
    @IBOutlet weak var suggestedexpenselabel: UILabel!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var expensetype: UILabel!
    
    
    @IBOutlet weak var expensetypelabel: UITextField!
    
    
    @IBOutlet weak var amountlabel: UILabel!
    
    
    @IBOutlet weak var currencybtn: UIButton!
    
    
    @IBOutlet weak var amounttextfield: UITextField!
    
    
    
    @IBOutlet weak var addbtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolors()
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        self.addbtn.layer.cornerRadius = self.addbtn.frame.size.height/2
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: expensetypelabel.frame.height - 1, width: expensetypelabel.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.clear.cgColor
//        expensetypelabel.borderStyle = UITextField.BorderStyle.none
        expensetypelabel.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.expensetypelabel.frame.size.height))
//        expensetypelabel.layer.addSublayer(bottomLine)
        
        expensetypelabel.attributedPlaceholder = NSAttributedString(string: "Enter here", attributes: [NSAttributedStringKey.foregroundColor : Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())])
        expensetypelabel.layer.borderWidth = 2
        expensetypelabel.layer.cornerRadius = expensetypelabel.frame.size.height/2
        expensetypelabel.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor
    
        
        
        var bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: amounttextfield.frame.height - 1, width: amounttextfield.frame.width, height: 1.0)
        bottomLine2.backgroundColor = UIColor.clear.cgColor
//        amounttextfield.borderStyle = UITextField.BorderStyle.none
        amounttextfield.layer.addSublayer(bottomLine2)
        amounttextfield.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedStringKey.foregroundColor : Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())])
        amounttextfield.layer.borderWidth = 2
        amounttextfield.layer.cornerRadius = amounttextfield.frame.size.height/2
        amounttextfield.layer.borderColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()).cgColor

    }
    
    
    func setupcolors()
    {
        let x = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        var r : CGFloat = 0.0
        var g : CGFloat = 0.0
        var b : CGFloat = 0.0
        var a : CGFloat = 0.0
        x.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.upperview.backgroundColor =  UIColor(red: r, green: g, blue: b, alpha: 0.8)
        
        self.backbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        let y = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary())
        var rr : CGFloat = 0.0
        var gg : CGFloat = 0.0
        var bb : CGFloat = 0.0
        var aa : CGFloat = 0.0
        y.getRed(&rr, green: &gg, blue: &bb, alpha: &aa)
        self.backgroundoverlay.backgroundColor = UIColor(red: rr, green: gg, blue: bb, alpha: 0.95)
        
        self.suggestedexpenselabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.expensetype.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.amountlabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.expensetypelabel.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amounttextfield.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.currencybtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.addbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        
        self.addbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.footerview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allsuggested.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "houseexpcell", for: indexPath) as? AddhouseexpenseCollectionViewCell {
            cell.update(x : self.allsuggested[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width/2.5 ,height : 130)
    }

   
}
