//
//  Customalert.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/30/20.
//  Copyright © 2020 PRIYESH . All rights reserved.
//

import Foundation
import UIKit

class Customalert
{
    static public var cs = Customalert()
    
    
    public func showalert(x : String , y : String) -> UIAlertController
    {
        
        let alert = UIAlertController(title: "\(x.capitalized)", message: "\(y.capitalized)",preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { _ in
            //Cancel Action
        }))
 
        return alert
    }
    
}
