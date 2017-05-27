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

class HPZHomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    var imagePicker: UIImagePickerController!
    var isTakePhoto = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefault.set(false, forKey: UserDefault_fist_login)
        // Do any additional setup after loading the view.
        HPZMainFrame.showMenuIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera) == false){
            return
        }
        imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        present(imagePicker, animated: true, completion: nil)
        isTakePhoto = true;
    }
    
    @IBAction func takeVideo(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera) == false){
            return
        }
        imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .video
        imagePicker.videoMaximumDuration = 1.0
        imagePicker.showsCameraControls = true
        present(imagePicker, animated: true, completion: nil)
        isTakePhoto = false
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if(isTakePhoto == true) {
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            HPZMainFrame.showReportPhoto(image: image!)
        } else {
            let videoUrl = info[UIImagePickerControllerMediaURL] as! NSURL
            HPZMainFrame.showReportVideo(videoUrl: videoUrl)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func getUserInfo() {
        HPZWebservice.shareInstance.getUserInfo(path:API_GET_USER,params:NSDictionary(),handler:{success , response in
            if(success) {
                if(response?.isKind(of: HPZUserModel.self))!{
                    let userInfo:HPZUserModel = response as! HPZUserModel
                    if(userInfo.code == 0) {
                        userDefault.set(userInfo.name, forKey: UserDefault_name)
                        userDefault.set(userInfo.mobileNumber, forKey: UserDefault_mobile_number)
                        userDefault.set(userInfo.address, forKey: UserDefault_address)
                        userDefault.set(userInfo.idNumber, forKey: UserDefault_id_number)
                        userDefault.set(userInfo.point, forKey: UserDefault_point)
                        HPZMainFrame.updateLeftMenu(userInfo: userInfo)
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: userInfo.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:HPZUserModel())
        
    }

}





