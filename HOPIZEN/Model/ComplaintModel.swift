//
//  ComplaintModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/27/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ComplaintModel: HPZBaseEntity {
    
    var code:NSInteger?
    var id:Int?
    var categoryId:Int?
    var categoryName:String?
    var image:String?
    var location:String?
    var district:String?
    var province:String?
    var address:String?
    var name:String?
    var time:String?
    var content:String?
    var isVideo:Bool = false
    var isPhoto:Bool = false
    
    var message:String?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
        
        if(code != 0) {
            message = data.value(forKey: "Message") as? String
            return
        }
        
        id = data.value(forKey: "violation_id") as? Int
        categoryId = data.value(forKey: "category_id") as? Int
        categoryName = data.value(forKey: "category_name") as? String
        image = data.value(forKey: "path") as? String
        location = data.value(forKey: "location") as? String
        address = data.value(forKey: "address") as? String
        district = data.value(forKey: "district") as? String
        province = data.value(forKey: "province") as? String
        name = data.value(forKey: "email") as? String
        time = data.value(forKey: "create_date") as? String
        content = data.value(forKey: "description") as? String
        isVideo = (data.value(forKey: "isVideo") as? Bool) ?? false
        isPhoto = (data.value(forKey: "isPhto") as? Bool) ?? false
    }
    
    func parserDataResponse(data:NSDictionary) -> Void {
        id = data.value(forKey: "violation_id") as? Int
        categoryId = data.value(forKey: "category_id") as? Int
        categoryName = data.value(forKey: "category_name") as? String
        image = data.value(forKey: "path") as? String
        location = data.value(forKey: "location") as? String
        address = data.value(forKey: "address") as? String
        district = data.value(forKey: "district") as? String
        province = data.value(forKey: "province") as? String
        name = data.value(forKey: "email") as? String
        time = data.value(forKey: "create_date") as? String
        content = data.value(forKey: "description") as? String
        isVideo = (data.value(forKey: "isVideo") as? Bool) ?? false
        isPhoto = (data.value(forKey: "isPhto") as? Bool) ?? false
    }

    
}
