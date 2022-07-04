//
//  Dataservices.swift
//  Expenseapp
//
//  Created by PRIYESH  on 5/13/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import Foundation
import Firebase

class Dataservices
{
    static var ds = Dataservices()
    private var _home = FIRDatabase.database().reference()
    private var _users = FIRDatabase.database().reference().child("users")
    private var _billsplits = FIRDatabase.database().reference().child("billsplits")
    private var _gamesplits = FIRDatabase.database().reference().child("gamesplits")
    private var _transactions = FIRDatabase.database().reference().child("transactions")
    
    var users:FIRDatabaseReference
    {
        get{return _users}
    }
    
    var home:FIRDatabaseReference
    {
        get{return _home}
    }

    
    var billsplits:FIRDatabaseReference
    {
        get{return _billsplits}
    }
    
    var gamesplits:FIRDatabaseReference
    {
        get{return _gamesplits}
    }
    
    var transactions:FIRDatabaseReference
    {
        get{return _transactions}
    }

    
}
