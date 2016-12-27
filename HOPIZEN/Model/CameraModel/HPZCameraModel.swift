//
//  HPZCameraModel.swift
//  CameraDemo
//
//  Created by Thuy Do Thanh on 12/27/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

class HPZCameraModel: HPZBaseEntity {
    var name1:String?
    var name2:String?
    var cameraID:String?
    var imageLink:String?
    var isOnline:Bool?
    
    
    override func paserStringRespon(istring: String) {
        print("respon:\(istring)")
        let splitData = istring.components(separatedBy: "////")
        if splitData.count == 3 {
            self.name1 = splitData[0]
            self.name2 = splitData[1]
            self.cameraID = splitData[2]
        }

    }
    
    
    func fillDataToCamera(iname1:String, iname2:String, icameraId:String) -> Void {
        self.name1 = iname1
        self.name2 = iname2
        self.cameraID = icameraId
    }

}
