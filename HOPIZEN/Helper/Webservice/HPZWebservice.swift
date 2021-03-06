//
//  HPZWebservice.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

import UIKit
import Foundation
import AFNetworking

typealias ServerResponseHandler = (_ success:Bool, _ response:HPZBaseEntity?) -> Void;

class HPZWebservice: NSObject {
    static let shareInstance = HPZWebservice()
    let requestManager:AFHTTPSessionManager!
    override init() {
        let securityPolicy:AFSecurityPolicy = AFSecurityPolicy();
        securityPolicy.allowInvalidCertificates = true
        securityPolicy.validatesDomainName = false;
        self.requestManager = AFHTTPSessionManager();
        let set = NSMutableSet(set: (self.requestManager!.responseSerializer.acceptableContentTypes)!)
        set.add("application/json")
        set.add("text/html")
        let setobj  = NSSet(set: set)
        self.requestManager.securityPolicy = securityPolicy;
        self.requestManager!.responseSerializer.acceptableContentTypes = setobj as? Set<String>
//        let requestSerializer:AFHTTPRequestSerializer = AFHTTPRequestSerializer()
        let requestSerializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        self.requestManager!.requestSerializer = requestSerializer
        self.requestManager!.responseSerializer = AFJSONResponseSerializer()
        self.requestManager!.requestSerializer.timeoutInterval = TimeInterval(HPZRequestConstant.HPZTimeout)
    }
    
    func makeFullAPIMethodWithAction(acction: String!,isAuthen:Bool) -> String! {
        return "\(isAuthen ? HPZHost.HOZOTherHost : HPZHost.HPZBaseHost)\(acction!)"
    }
    
    
    func sendGETRequest(path:String!,
                        params:NSDictionary?,
                        responseObjectClass:HPZBaseEntity!,
                        isAuthen:Bool,
                        responseHandler:@escaping ServerResponseHandler) -> Void {
        print("\(self.makeFullAPIMethodWithAction(acction: path!, isAuthen: isAuthen)) params - > \(params!)")
        if(isAuthen) {
            let email = userDefault.string(forKey: UserDefault_email) ?? ""
            let password = userDefault.string(forKey: UserDefault_password) ?? ""
            self.requestManager!.requestSerializer.setAuthorizationHeaderFieldWithUsername(email, password: password)
        }
        self.requestManager!.requestSerializer.timeoutInterval = TimeInterval(HPZRequestConstant.HPZTimeout)
        self.requestManager!.get(self.makeFullAPIMethodWithAction(acction: path!, isAuthen: isAuthen), parameters: params, progress: nil, success: {(task, responseObject) -> Void in
            print("responseObject ->> \(responseObject)")
            if responseObject is NSDictionary {
                responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            } else {
                responseObjectClass.parserResponse(dic: responseObject as! NSDictionary)
            }
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            responseHandler(false, nil);
            
            
        }
            
        )
    }
    
    func sendOrderCoinRequest(path:String!,
                        params:NSDictionary?,
                        responseObjectClass:HPZBaseEntity!,
                        responseHandler:@escaping ServerResponseHandler) -> Void {
        print("\(self.makeFullAPIMethodWithAction(acction: path!, isAuthen: true)) params - > \(params!)")
        let authen = getCoinAuth()
        self.requestManager!.requestSerializer.setValue(authen, forHTTPHeaderField: "Authorization")
        let nonce = getUnixtime();
        self.requestManager!.requestSerializer.setValue(nonce, forHTTPHeaderField: "X-Nonce")
        let hasNonce = sha256(data: nonce.data(using: String.Encoding.utf8)!)
        let urlRequest = path + (params?.queryParameters)!.replace(target: "+", withString: "%2B")
        let urlHash = urlRequest.replace(target: COIN_URL, withString: "");
        let signature = DigestHmacSha512(input: urlHash + hasNonce)
        self.requestManager!.requestSerializer.setValue(signature, forHTTPHeaderField: "X-Signature")
        
        self.requestManager!.requestSerializer.timeoutInterval = TimeInterval(HPZRequestConstant.HPZTimeout)
        self.requestManager!.get(self.makeFullAPIMethodWithAction(acction: urlRequest, isAuthen: true), parameters: NSDictionary(), progress: nil, success: {(task, responseObject) -> Void in
            print("responseObject ->> \(String(describing: responseObject))")
            if responseObject is NSDictionary {
                responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            } else {
                responseObjectClass.parserResponse(dic: responseObject as! NSDictionary)
            }
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            print("responseObject ->> \(String(describing: responseOBJ))")
            responseHandler(false, nil);
            
        })
        
    }

    
    
    func sendPOSTRequest (path:String!,
                          params:NSDictionary?,
                          responseObjectClass:HPZBaseEntity!,
                          isAuthen:Bool,
                          responseHandler:@escaping ServerResponseHandler) -> Void {
        print("\(self.makeFullAPIMethodWithAction(acction: path!, isAuthen: isAuthen)) -> params ->>\(params!)")
        if(isAuthen) {
            let email = userDefault.string(forKey: UserDefault_email) ?? ""
            let password = userDefault.string(forKey: UserDefault_password) ?? ""
            self.requestManager!.requestSerializer.setAuthorizationHeaderFieldWithUsername(email, password: password)
        }
        
        self.requestManager!.post(self.makeFullAPIMethodWithAction(acction: path!, isAuthen: isAuthen), parameters:params //self.convertParamsToJson(params: params!)
            , progress: nil, success: {(task, responseObject) -> Void in
                
                print("responseObject ->> \(String(describing: responseObject))")
                
                responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
                responseHandler(true, responseObjectClass);
                
                
        }, failure: { (task, responseOBJ) -> Void in
            print(task?.error ?? "error  null")
            responseHandler(false, nil);
            
        }
        )
        
    }
    
    func sendMultiPartFile(path: String,params:NSDictionary?, fileData: Data!, fileName: String, responseObjectClass:HPZBaseEntity!,
                           responseHandler:@escaping ServerResponseHandler) -> Void {
        let email = userDefault.string(forKey: UserDefault_email) ?? ""
        let password = userDefault.string(forKey: UserDefault_password) ?? ""
        self.requestManager!.requestSerializer.setAuthorizationHeaderFieldWithUsername(email, password: password)
        
        self.requestManager!.post(path, parameters: params, constructingBodyWith: { (data: AFMultipartFormData!) in
            data.appendPart(withFileData: fileData, name: "", fileName: fileName, mimeType: "image/*")
        }, progress: nil,success: {(task, responseObject) -> Void in
             print("responseObject ->> \(String(describing: responseObject))")
              responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            responseHandler(true, responseObjectClass);
                                    
        }, failure: { (task, responseOBJ) -> Void in
            print(task?.error ?? "error  null")
            responseHandler(false, nil);
            
        })
    }
    
    
    private func convertParamsToJson(params:NSDictionary) -> String {
        
        do {
            
            if let data:NSData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) as NSData? {
                let jsonString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
                print(jsonString)
                //
                
                return jsonString
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
    
    
}


extension HPZWebservice {
    
    func loginWithFacebook(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity, isAthen:Bool) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: isAthen, responseHandler: handler)
    }
    
    func loginWithEmail(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity, isAthen:Bool) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: isAthen, responseHandler: handler)
    }
    
    func findPakingPlace(path:String,params:NSDictionary, entity:HPZBaseEntity,isAuthen:Bool,handler:@escaping ServerResponseHandler) -> Void {
        self.sendGETRequest(path: path, params: params, responseObjectClass: entity, isAuthen: isAuthen, responseHandler: handler)
    }
    //API register
    func registerUser(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity, isAthen:Bool) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: isAthen, responseHandler: handler)
    }
    
    func getComplaintList(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendGETRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    
    func getCategoryList(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendGETRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    
    func getCampaignList(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendGETRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }

    func getUserInfo(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendGETRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    
    func getSendOrder(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendOrderCoinRequest(path: path, params: params, responseObjectClass: entity, responseHandler: handler);
    }
    
    func convertPoint(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    
    func updatePoint(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    
    func updateComplaint(path:String,params:NSDictionary,handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendPOSTRequest(path: path, params: params, responseObjectClass: entity, isAuthen: true, responseHandler: handler)
    }
    func uploadFile(path:String,fileData: Data!,fileName:String, handler:@escaping ServerResponseHandler, entity:HPZBaseEntity) -> Void {
        self.sendMultiPartFile(path: path,params: NSDictionary(), fileData: fileData,fileName: fileName, responseObjectClass: entity, responseHandler: handler)
    }
    
}
