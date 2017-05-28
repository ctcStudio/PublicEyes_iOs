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

let IMAGE_URL                                   = "http://acquyxenangdien.net"
let API_URL                                     = "http://acquyxenangdien.net/api"
let API_LOGIN                                   = API_URL + "/login"
let API_RESGISTER                               = API_URL + "/user"
let API_GET_USER                                = API_URL + "/user/getbyuser"
let API_GET_CATEGORY                            = API_URL + "/category/getallcategory"
let API_GET_COMPLAINT                           = API_URL + "/violation/getbyuser"
let API_GET_CAMPAIGN                            = API_URL + "/operation"
let API_UPLOAD_FILE                             = API_URL + "/violation/file"
let API_UPDATE_COMPLAINT                        = API_URL + "/violation"

let UserDefault_email                           = "user.default.email"
let UserDefault_password                        = "user.default.password"
let UserDefault_fist_login                      = "user.default.first.login"
let UserDefault_name                            = "user.default.name"
let UserDefault_mobile_number                   = "user.default.mobile_number"
let UserDefault_id_number                       = "user.default.id.number"
let UserDefault_address                         = "user.default.address"
let UserDefault_point                           = "user.default.point"

let userDefault                                 = UserDefaults.standard
func isActive() -> Bool {
    let email = userDefault.string(forKey: UserDefault_email)
    let password = userDefault.string(forKey: UserDefault_password);
    return (email?.isEmpty == false && password?.isEmpty == false)
}
func clearUserData() -> Void {
    userDefault.set("", forKey: UserDefault_email)
    userDefault.set("", forKey: UserDefault_password)
    userDefault.set(true, forKey: UserDefault_fist_login)
}

func getImageUrl(path:String) -> String {
    return (IMAGE_URL + path)
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
