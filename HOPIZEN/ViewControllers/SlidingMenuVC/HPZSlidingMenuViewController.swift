//
//  HPZSlidingMenuViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

class HPZSlidingMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gotoComplaint(_ sender: Any) {
    }
    
    @IBAction func gotoCampaign(_ sender: Any) {
    }

    @IBAction func logout(_ sender: Any) {
        HPZMainFrame.hidenMenu()
        clearUserData()
        HPZMainFrame.showFirstVC()
    }
    
}
