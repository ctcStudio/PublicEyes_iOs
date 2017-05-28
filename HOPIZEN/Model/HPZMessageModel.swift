//
//  HPZMessageModel.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/26/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import Foundation
class HPZMessageModel: HPZBaseEntity {
    var code:NSInteger?
    var message:String?
    var path:String?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
        message = data.value(forKey: "Message") as? String
        path = data.value(forKey: "Path") as? String
    }
    
}
