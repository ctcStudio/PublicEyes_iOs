//
//  OrderModel.swift
//  PublicEyes
//
//  Created by hunghoang on 8/5/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class OrderModel: HPZBaseEntity {
    var transRef:String?;
    var sendOrderId:String!;
    var userNoPhone:String!;
    var amount:Int?;
    var address:String?;
    var createdOn:String?;
    var time:String?;
    var status:Int = 200;
    var callbackData:String?;
    
    override func parserResponse(dic:NSDictionary) -> Void {
        if let val = dic.value(forKey: "transRef") as?String {
            transRef = val;
        }
        
        if let val = dic.value(forKey: "sendOrderId") as?String {
            sendOrderId = val;
        }
        
        if let val = dic.value(forKey: "userNophone") as?String {
            userNoPhone = val;
        }
        
        if let val = dic.value(forKey: "amount") as?Int {
            amount = val;
        }
        
        if let val = dic.value(forKey: "address") as?String {
            address = val;
        }
        
        if let val = dic.value(forKey: "createOn") as?String {
            createdOn = val;
        }
        
        if let val = dic.value(forKey: "status") as?Int {
            status = val;
        }
        
        if let val = dic.value(forKey: "callback_data") as?String {
            callbackData = val;
        }
        
        
    }
}
