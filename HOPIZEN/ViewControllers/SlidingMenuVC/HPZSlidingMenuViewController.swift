//
//  HPZSlidingMenuViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

class HPZSlidingMenuViewController: UIViewController {

    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvPoint: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInfo(userInfo: HPZUserModel) -> Void {
        tvName.text = userInfo.name
        tvPoint.text = String.init(userInfo.point)
    }
    

    @IBAction func gotoComplaint(_ sender: Any) {
        HPZMainFrame.hidenMenu()
        HPZMainFrame.showMyComplaintVC()
    }
    
    @IBAction func gotoCampaign(_ sender: Any) {
        HPZMainFrame.hidenMenu()
        HPZMainFrame.showCampaignVC()
    }

    @IBAction func logout(_ sender: Any) {
        HPZMainFrame.hidenMenu()
        clearUserData()
        HPZMainFrame.showFirstVC()
    }
    
    @IBAction func changeToMoney(_ sender: Any) {
    }
}
