//
//  HouseexpensesViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 5/2/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class HouseexpensesViewController: UIViewController {
    
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    @IBOutlet weak var backgroundimage: UIImageView!
    
    @IBOutlet weak var backgroundoverlay: UIView!
    
    
    @IBOutlet weak var housename: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var startingspan: UILabel!
    
    
    @IBOutlet weak var addexpbtn: UIButton!
    
    
    @IBOutlet weak var footerview: UIView!
    
    @IBOutlet weak var viewdetailedexpensesbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcolors()
        self.addexpbtn.layer.cornerRadius = 25

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
        
        self.housename.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.amount.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.startingspan.textColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.addexpbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimary()), for: .normal)
        self.addexpbtn.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        self.footerview.backgroundColor = Theme.theme.hexStringToUIColor(hex: Theme.theme.getsecondary())
        self.viewdetailedexpensesbtn.setTitleColor(Theme.theme.hexStringToUIColor(hex: Theme.theme.getsecondaryfont()), for: .normal)
        
    }
    

   

}
