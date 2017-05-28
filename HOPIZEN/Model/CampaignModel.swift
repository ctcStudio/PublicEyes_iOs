//
//  CampaignModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/27/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CampaignModel: HPZBaseEntity {
    var code:NSInteger?
    var id:Int?
    var image:String?
    var tile:String?
    var fromDate:String?
    var toDate:String?
    var content:String?
    var point:Int = 0
    
    var message:String?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
        
        if(code != 0) {
            message = data.value(forKey: "Message") as? String
            return
        }
        
        id = data.value(forKey: "operation_id") as? Int
        image = data.value(forKey: "image") as? String
        tile = data.value(forKey: "name") as? String
        fromDate = data.value(forKey: "date_from") as? String
        toDate = data.value(forKey: "date_to") as? String
        content = data.value(forKey: "description") as? String
        point = (data.value(forKey: "bonusPoint") as? Int) ?? 0
    }
    
    func parserDataResponse(data:NSDictionary) -> Void {
        id = data.value(forKey: "operation_id") as? Int
        image = data.value(forKey: "image") as? String
        tile = data.value(forKey: "name") as? String
        fromDate = data.value(forKey: "date_from") as? String
        toDate = data.value(forKey: "date_to") as? String
        content = data.value(forKey: "description") as? String
        point = (data.value(forKey: "bonusPoint") as? Int) ?? 0
    }
    
}
