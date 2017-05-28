//
//  CategoryModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/27/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CategoryModel: HPZBaseEntity {
    var code:NSInteger?
    var id:Int?
    var image:String?
    var name:String?
    
    var message:String?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
        
        if(code != 0) {
            message = data.value(forKey: "Message") as? String
            return
        }
        id = data.value(forKey: "category_id") as? Int
        image = data.value(forKey: "path") as? String
        name = data.value(forKey: "name") as? String
    }
    
    func parserDataResponse(data:NSDictionary) -> Void {
        id = data.value(forKey: "category_id") as? Int
        image = data.value(forKey: "path") as? String
        name = data.value(forKey: "name") as? String
    }
}
