//
//  CategoryTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/27/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
//    var allcategories = ["individuals","teachers","workers","bills","household expenses","buisness expenses"]
    
    var allcategories = ["individuals", "bills" ,"office expenses","house expenses"]
    
    @IBOutlet weak var collection: UICollectionView!
    
    var takeback : ((_ x : String) -> Void)?
    
    func update()
    {
        self.backgroundColor = UIColor.clear
        collection.delegate = self
        collection.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        layout.minimumInteritemSpacing = 0
        //        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.collection.frame.size.width / 2.2, height: 200)
        //        layout.estimatedItemSize = CGSize(width: self.collection.frame.size.width / 2.5, height: 190)
        collection.collectionViewLayout = layout
        //        collection.allowsSelection = true
        //        collection.allowsMultipleSelection = false
        
        collection.reloadData()
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allcategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycollection", for: indexPath) as?
        CategoryCollectionViewCell{
            
            cell.update(x : allcategories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width / 2.2, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.takeback?(self.allcategories[indexPath.row])
    }
    
    
    
    

}
