//
//  HPZConstant.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

let naviColor                                   = 0x3c3f41

let screenBounds                                = UIScreen.main.bounds
let screenSize                                  = screenBounds.size
let screenWidth                                 = screenSize.width
let screenHeight                                = screenSize.height
let statusBarHeight                             = UIApplication.shared.statusBarFrame.height

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

let COIN_REG_LINK = "https://wallet.vngcoin.com"
let COIN_URL = "https://tmapi.vngcoin.com"
let COIN_API_URL = COIN_URL + "/gateway"
let API_COIN_SEND = COIN_API_URL + "/send_order"

let NUMBER_COIN_CHANGE = 10
let NO_PHONE = "+84984921226"
let API_NUMBER = "1f52d883-20ba-4bfe-b584-9213ab7040a0"
let SECRET = "a13a927b-c9ea-46d5-98d9-1ffdcaa14b60"
let COIN_SUCCESS = 1

func getCoinAuth() -> String {
    let str = NO_PHONE + ":" + API_NUMBER
    let utf8str = str.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString()
    return base64Encoded!
}

func getUnixtime() -> String {
    let time = Int64.init(Date().timeIntervalSince1970);
    return String.init(time)
}

func sha256(data : Data) -> String {
    var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes {
        _ = CC_SHA256($0, CC_LONG(data.count), &hash)
    }
    let data:NSData =  Data(bytes: hash) as NSData
    return data.base64EncodedString()
}

// hmacSHA-512 to string hex
func DigestHmacSha512(input : String) -> String {
    return input.hmac(algorithm: CryptoAlgorithm.SHA512, key: SECRET)
}


let UserDefault_email                           = "user.default.email"
let UserDefault_password                        = "user.default.password"
let UserDefault_fist_login                      = "user.default.first.login"
let UserDefault_name                            = "user.default.name"
let UserDefault_mobile_number                   = "user.default.mobile_number"
let UserDefault_id_number                       = "user.default.id.number"
let UserDefault_address                         = "user.default.address"
let UserDefault_point                           = "user.default.point"
let UserDefault_TRANS_ID                        = "user.default.trans.id"

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

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

