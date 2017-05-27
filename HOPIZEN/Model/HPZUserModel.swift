//
//  HPZUserModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/27/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class HPZUserModel: HPZBaseEntity {
    var code:NSInteger?
    var id:Int?
    var email:String?
    var name:String?
    var mobileNumber:String?
    var idNumber:String?
    var address:String?
    var point:Int = 0
    var age:Int = 0
    
    var message:String?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
        
        if(code != 0) {
            message = data.value(forKey: "Message") as? String
            return
        }
        id = data.value(forKey: "decentralization_id") as? Int
        email = data.value(forKey: "email") as? String
        name = data.value(forKey: "name") as? String
        mobileNumber = data.value(forKey: "mobile_number") as? String
        idNumber = data.value(forKey: "id_card") as? String
        address = data.value(forKey: "address") as? String
        point = (data.value(forKey: "bonus_point") as? Int) ?? 0
        age = (data.value(forKey: "age") as? Int) ?? 0
    }
    
}
