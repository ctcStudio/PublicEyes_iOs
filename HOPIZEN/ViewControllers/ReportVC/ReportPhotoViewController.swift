//
//  ReportPhotoViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ReportPhotoViewController: UIViewController {
    var image:UIImage!

    @IBOutlet weak var imageComplaint: UIImageView!
    @IBOutlet weak var tvDecription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vi Phạm"
        // Do any additional setup after loading the view.
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
        HPZMainFrame.addMenuRight(title: "Upload", titleColor: UIColor.yellow, target: self, action: #selector(clickUpload(_:)))
        hideKeyboardWhenTappedAround()
        imageComplaint.image = image
    }
    
    func clickBack(_ sender:UIButton!){
        HPZMainFrame.showHomeVC()
    }
    func clickUpload(_ sender:Any!){
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        HPZWebservice.shareInstance.uploadFile(path: API_UPLOAD_FILE, fileData: imageData, handler:{success , response in
            if(success) {
                if(response?.isKind(of: HPZMessageModel.self))!{
                    let message:HPZMessageModel = response as! HPZMessageModel
                    if(message.code == 0) {
                        HPZMainFrame.showCategoryPhoto(image: self.image, path: message.path, des: self.tvDecription.text)
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: message.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:HPZMessageModel())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
