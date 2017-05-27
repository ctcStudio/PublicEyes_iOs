//
//  ListComplaintModel.swift
//  PublicEyes
//
//  Created by HungHN on 5/27/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ListComplaintModel: HPZBaseEntity {
    var code:NSInteger?
    var message:String?
    var complaintList:NSMutableArray = []
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        if(code != 0) {
            let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
            message = data.value(forKey: "Message") as? String
            return
        } else {
            let dataArr:NSArray = (dic.object(forKey: "Data") as? NSArray) ?? []
            for data in dataArr {
                let complaint = ComplaintModel()
                complaint.parserDataResponse(data: data as! NSDictionary)
                complaintList.add(complaint)
            }
        }
        
    }
}
