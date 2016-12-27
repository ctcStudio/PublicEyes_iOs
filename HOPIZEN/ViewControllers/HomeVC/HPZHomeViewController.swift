//
//  HPZHomeViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit
import SwiftSocket
import Foundation

class HPZHomeViewController: UIViewController{

    var sk:HPZSoketXXXXX?
    lazy var isFrist = false;
    
    
    lazy var cameraList:[HPZCameraModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.connectSocket()
        
//        self.testSocket()
        self.test5()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    private func connectSocket() -> Void {
//        Tlog(logMessage:"start connect to socket...")
//        let client = TCPClient(address: "haicuong.no-ip.biz", port:5050)
//        switch client.connect(timeout:20) {
//        case .success:
//            Tlog(logMessage:"connect to socket success...")
//            let mMessage = "@haicuong@:demo:123456"
//            switch client.send(string: mMessage ) {
//            case .success:
//                Tlog(logMessage:"send messge:\(mMessage) to server sucess")
//                guard let data = client.read(1024*10) else { return }
//                if let response = String(bytes: data, encoding: .utf8) {
//                    Tlog(logMessage:"Response:\(response)")
//                }
//            case .failure(let error):
//                Tlog(logMessage:"send messgae to server error: \(error)")
//            }
//            break
//
//        case .failure(let error):
//            Tlog(logMessage:"\(error)")
//        }
//        
//    }
//    
    
    func test5() -> Void {
        let host:NSString = "haicuong.no-ip.biz"
        self.sk = HPZSoketXXXXX(host:host as String! , port: 5050);
        self.sk?.delegate = self
        
    }
}

extension HPZHomeViewController : HPZSoketXXXXXDelegate {
    func socketDidConnect() {
        print("socketDidConnect")
        self.pSendMessage()
        
    }
    
    func messageReceived(_ message: String!) {
//        print("message:\(message)")
        if message.contains(find: "@message@khoitaohethong@message@")
            || message.contains(find: "cameralistend")
            || message.contains(find: "@message@ketthuckhoitaohethong@message@"){
            
            if message.contains(find: "////") {
                let modified = message.replace(target: "\0", withString:"")
                let splitData = modified.components(separatedBy: "\r\n")
                
                for value in splitData {
                    if value.contains(find: "////")  {
                        let camera = HPZCameraModel()
                        let splitDataDetail = value.components(separatedBy: "////")
                        
                        var u = 0
                        for _ in 0..<((splitDataDetail.count - 1)/2) {
                            u = u + 1
                            let name2 = splitDataDetail[u]
                            u = u + 1
                            let iid = splitDataDetail[u]
                            camera.fillDataToCamera(iname1: splitDataDetail[0], iname2: name2, icameraId: iid)
                            self.cameraList.append(camera)
                        }
                       
                    }
                }
                
                if self.cameraList.count > 0 {
                    self.sendMessageCheckOnline()
                }
            }
        } else if message.contains(find: "@message@checkonline@message@") {
            self.fillterCameraOnline(messsage: message)
            
        }
       
    }
    
    
    @objc private func pSendMessage() -> Void {
       
        let mMessage:NSString = "@haicuong@:demo:123456"
        self.sk?.sendMessage(toServer: mMessage as String!)
    }
    
    
    private func sendMessageCheckOnline() -> Void {
        var message = "@message@checkonline@message@"
        var idString = ""
       
        var i = 0
        for value in self.cameraList {
            if i == 0 {
                idString = "////"
            }
            idString = idString + value.cameraID! + "////"
            i = i + 1
        }
        
        message = message + idString
        self.sk?.sendMessage(toServer: message as String!)
    }
    
    private func fillterCameraOnline(messsage:String) -> Void {
        if messsage.contains(find: "////")  {
            let splitDataDetail = messsage.components(separatedBy: "////")
            for value in splitDataDetail {
                for value2 in self.cameraList {
                    if value2.cameraID == value {
                        value2.isOnline = true
                    }
                }
            }
        }
        
        self.getRealTime()
    }
    
    
    private func getRealTime() -> Void {
        let mMessage:NSString = "@haicuongplayer@:demo:123456"
        self.sk?.sendMessage(toServer: mMessage as String!)
        for value in self.cameraList {
            if value.isOnline == true {
                let message2 = "@message@yeucaulive@message@////\(value.cameraID ?? "")////"
                self.sk?.sendMessage(toServer: message2 as String!)

            }
        }

    }
    
}





