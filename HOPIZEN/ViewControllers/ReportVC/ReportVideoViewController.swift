//
//  ReportVideoViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ReportVideoViewController: UIViewController {
    var videoUrl:NSURL!

    @IBOutlet weak var tvDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
    }
    
    func clickBack(_ sender:UIButton!){
        HPZMainFrame.showHomeVC()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continues(_ sender: Any) {
        do {
            let videoData = try Data.init(contentsOf: videoUrl as URL, options: .mappedIfSafe)
            
            HPZWebservice.shareInstance.uploadFile(path: API_UPLOAD_FILE, fileData: videoData, handler:{success , response in
                if(success) {
                    if(response?.isKind(of: HPZMessageModel.self))!{
                        let message:HPZMessageModel = response as! HPZMessageModel
                        if(message.code == 0) {
                            HPZMainFrame.showCategoryVideo(videoUrl: self.videoUrl, path: message.path, des: self.tvDescription.text)
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
        } catch {
            print(error)
            return
        }
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
