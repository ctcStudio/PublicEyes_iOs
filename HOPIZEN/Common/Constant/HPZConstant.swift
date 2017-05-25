//
//  HPZConstant.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

let naviColor                                   = 0x5456AC

let screenBounds                                = UIScreen.main.bounds
let screenSize                                  = screenBounds.size

let screenWidth                                 = screenSize.width
let screenHeight                                = screenSize.height
let UserDefault_email                           = "user.default.email"
let UserDefault_password                           = "user.default.password"

func isActive() -> Bool {
    let userDefauts = UserDefaults.standard
    let email = userDefauts.string(forKey: UserDefault_email)
    let password = userDefauts.string(forKey: UserDefault_password);
    return (email?.isEmpty == false && password?.isEmpty == false)
}


func Tlog(logMessage:String, functionName: String = #function, line:Int = #line, lClass:String = #file) {
    print("FILE-\(lClass):FUCN-\(functionName):LINE-\(line): \(logMessage)")
}


struct GoogleKey {
    static let API_KEY  = "AIzaSyDDLa5Do1zXKOs1YAWFVazh4tbXy4JWv-A"
}

struct PDevice {
    static let key_uuid_app     = "KEY_UUID_APP"
    static let os_name          = "IOS"
    static let os_version       = UIDevice.current.systemVersion
    
}
