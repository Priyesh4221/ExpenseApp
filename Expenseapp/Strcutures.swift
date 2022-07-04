//
//  Strcutures.swift
//  Expenseapp
//
//  Created by PRIYESH  on 4/10/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import Foundation

public struct contacts {
    var name : String?
    var type : String?
    var amount : String?
    var userid : String?
    var profileimage : String?
    var gender : String?
    var email : String?
    var status : String?
    var currency : String?
    var crossverification : Bool?
}

struct category {
    var title:String
    var subtitle:String
}

struct record {
    var amount:String
    var date:Int64
    var title:String
    var transactionid : String
    var status : String
    var category : String
    var comment : String
    var creator : String
    var paidby : String
    var receivedby : String
    var subject : String
    var verified : String
}

struct PreviousRecord {
    var amount : Int
    var date : String
    var purpose : String
}

struct subjectdetail {
    var subjectname : String
    var feesmode : String
    var feesamount : Int
    var noofclasses : Int
}

struct user {
    var name : String
    var id : String
    var selected : Bool
    var email : String
    var mobile : String
    var gender : String
    var profileimage : String
    var status : String
    var currency : String
    var billamountpaidinadvance : Int = 0
    var ratioinwhichbillsplit : Int = 1
}

struct personRank
{
    var id : String?
    var rank : Int?
    var partTobePaid : Double?
    var shareAfterPayment : Double?
}

struct billsplittransaction {
    var billname : String?
    var category :String?  // equal,ratio or gamesplit
    var comment: String?
    var mode : String? //fixed or timer
    var amount : Double?
    var receipients : [user]?
    var billamountsgenerated : [Double]
    var duration : String? // only in timer case, format 01:10:08
    var rate : Double? // only in timer case
    var ranks : [personRank]?
}


struct notification
{
    var key : String
    var category : String
    var title : String
    var matter : String
    var time : Int64
    var fromuser : String
    var needapproval : Bool
    var receipientresponded : Bool
    var referenceid : String
    var type : String
    var status : String
}

struct billshowreceipients
{
    var amountafterspliting : [Int64]
    var paidadvance : [Int64]
    var paymentleft : [Int64]
    var splitratio : Int
    var verified : String
    var username : String
    var userimage : String
    var userid : String
}

struct billshow
{
    var category : String
    var comment : String
    var creatorid : String
    var creatorname : String = ""
    var creatorimagelink : String = ""
    var date : String
    var netamount : Int64
    var subject : String
    var receipients : [billshowreceipients]
    var timestamp : Int64
    var billid : String
}


struct officeexpenserecord
{
    var addedby : String
    var amount : Int
    var createdon : Int64
    var mode : String
    var subject : String
}


struct fetchofficeexpenses
{
    var name : String
    var roomid : String
    
}



struct basicuser
{
    var userid : String
    var name : String
    var email : String
    var countrycode : String
    var mobile : String
    var currency : String
    var gender : String
    var profileimageurl : String
}



struct profileuser
{
    var userid : String
    var name : String
    var email : String
    var mobile  : String
    var countrycode : String
    var gender : String
    var currency : String
    var account : String
    var plan : String
    var profileimage : String
}
