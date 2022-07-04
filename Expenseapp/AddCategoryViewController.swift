//
//  AddCategoryViewController.swift
//  Expenseapp
//
//  Created by PRIYESH  on 10/24/18.
//  Copyright © 2018 PRIYESH . All rights reserved.
//

import UIKit


class AddCategoryViewController: UIViewController , UITableViewDelegate ,  UITableViewDataSource {
    
 
    @IBOutlet weak var navbarhead: UILabel!
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var profilebtn: UIButton!
    
    
    @IBOutlet weak var navbar: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var lowerview: UIView!
    
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
        
        self.lowerview.backgroundColor =  hexStringToUIColor(hex: Theme.theme.getsecondary())
        
        self.navbarhead.textColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
        
        self.backbtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        self.profilebtn.setTitleColor(hexStringToUIColor(hex: Theme.theme.getprimaryfont()), for: .normal)
        
        self.search.tintColor = hexStringToUIColor(hex: Theme.theme.getprimaryfont())
              self.search.barTintColor = hexStringToUIColor(hex: Theme.theme.getprimary())
        
    }
    
    override func viewWillLayoutSubviews() {
        setupcolors()
    }
    
    
    
    var contents = [category]()
    
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.fetchdata()

        // Do any additional setup after loading the view.
    }
    
    func fetchdata()
    {
        var x = category(title: "individual", subtitle: "for any person to maintain accounts uncertainly")
         var y = category(title: "Teacher", subtitle: "To maintain record of payment and classes")
         var z = category(title: "personal expenses", subtitle: "to track personal or monthly household expenses")
         var w = category(title: "worker", subtitle: "includes worker with payment after fixed span of time \n (Maid , Cook, Garderner etc)")
        self.contents.append(x)
        self.contents.append(y)
        self.contents.append(z)
        self.contents.append(w)
        self.table.reloadData()
    }

    
    @IBAction func goback(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backpressed(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell", for: indexPath) as? AddCategoryTableViewCell
        {
            cell.updatecell(x: self.contents[indexPath.row].title, y: self.contents[indexPath.row].subtitle)
            return cell
        }
        return  UITableViewCell()
    }
    
    var selectedindex : Int!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedindex = indexPath.row
        if indexPath.row == 0
        {
            performSegue(withIdentifier: "addindividual", sender: nil)
        }
        else if indexPath.row == 1 || indexPath.row == 3
        {
            
            performSegue(withIdentifier: "addteacher/worker", sender: nil)
        }
        else if indexPath.row == 2
        {
            
        }
       
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(selectedindex == 1 || selectedindex == 3)
        {
            if let seg = segue.destination as? WorkerViewController
            {
                if(selectedindex == 1)
                {
                    seg.selectedcategory = "teacher"
                }
                else
                {
                    seg.selectedcategory = "worker"
                }
            }
        }
    }
    

}
