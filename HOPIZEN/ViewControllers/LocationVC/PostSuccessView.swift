//
//  PostSuccessView.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class PostSuccessView: UIView {

    @IBOutlet weak var btnViewComplaint: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func gotoCampaint(_ sender: Any) {
        HPZMainFrame.showMyComplaintVC()
    }
    @IBAction func gotoHome(_ sender: Any) {
        HPZMainFrame.showHomeVC()
    }
}
