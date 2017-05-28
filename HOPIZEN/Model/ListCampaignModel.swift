//
//  ListCampaignModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/28/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//
import UIKit

class ListCampaignModel: HPZBaseEntity {
    var code:NSInteger?
    var message:String?
    var campaignList:NSMutableArray = []
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        if(code != 0) {
            let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
            message = data.value(forKey: "Message") as? String
            return
        } else {
            let dataArr:NSArray = (dic.object(forKey: "Data") as? NSArray) ?? []
            for data in dataArr {
                let campaing = CampaignModel()
                campaing.parserDataResponse(data: data as! NSDictionary)
                campaignList.add(campaing)
            }
        }
        
    }
}
