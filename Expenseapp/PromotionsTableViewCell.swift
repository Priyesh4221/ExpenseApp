//
//  PromotionsTableViewCell.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/26/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import UIKit

class PromotionsTableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    
    
    


    
    @IBOutlet weak var collection: UICollectionView!
    
    
    
    
    
    func update()
    {
        print("WTF")
        collection.delegate = self
        collection.dataSource = self
        self.selectionStyle = .none
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.collection.frame.size.width * 0.8, height: 200)
//        layout.estimatedItemSize = CGSize(width: self.collection.frame.size.width / 2.5, height: 190)
        collection.collectionViewLayout = layout
//        collection.allowsSelection = true
//        collection.allowsMultipleSelection = false
        
        collection.reloadData()
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Collection sections")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Collection rows")
        return 4
    }
    
    
   
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("hello")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promocollec", for: indexPath) as? PromotionCollectionViewCell {
            print("Heyy")
            cell.update()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Collection Height")
        return CGSize(width: self.collection.frame.size.width * 0.8, height: 200)
    }
    
    
    
    
    
}
