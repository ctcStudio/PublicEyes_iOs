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
        
        // Do any additional setup after loading the view.
        HPZMainFrame.showMenuIcon()
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
    
}





