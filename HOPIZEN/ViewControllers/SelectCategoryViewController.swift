//
//  SelectCategoryViewController.swift
//  PublicEyes
//
//  Created by HungHN on 7/1/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    var image:UIImage?
    var videoUrl:NSURL?
    var path:String!
    var des: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chon Danh Muc"
        // Do any additional setup after loading the view.
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
    }
    
    func clickBack(_ sender:UIButton!){
        if(image != nil) {
            HPZMainFrame.showReportPhoto(image: image!)
        } else if(videoUrl != nil) {
            HPZMainFrame.showReportVideo(videoUrl: videoUrl!)
        } else{
            HPZMainFrame.showHomeVC()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func selectMotor(_ sender: Any) {
        if(image != nil) {
            HPZMainFrame.showCategoryPhoto(type: CategoryTableViewController.TYPE_MOTOR, image: image!, path: path, des: des)
        } else if(videoUrl != nil) {
            HPZMainFrame.showCategoryVideo(type: CategoryTableViewController.TYPE_MOTOR, videoUrl: videoUrl!, path: path, des: des)
        }
    }
    
    
    @IBAction func selectCar(_ sender: Any) {
        if(image != nil) {
            HPZMainFrame.showCategoryPhoto(type: CategoryTableViewController.TYPE_CAR, image: image!, path: path, des: des)
        } else if(videoUrl != nil) {
            HPZMainFrame.showCategoryVideo(type: CategoryTableViewController.TYPE_CAR, videoUrl: videoUrl!, path: path, des: des)
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
