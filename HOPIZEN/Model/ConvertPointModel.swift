//
//  ConvertPointModel.swift
//  PublicEyes
//
//  Created by HungHN on 9/12/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ConvertPointModel: HPZBaseEntity {
    var code:NSInteger?
    var point:NSInteger?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        code = dic.value(forKey: "Code") as? NSInteger
        if(code == 0) {
            let data:NSDictionary = dic.value(forKey: "Data") as! NSDictionary
            point = data.value(forKey: "point") as? NSInteger
            return
        }
        
    }

}
