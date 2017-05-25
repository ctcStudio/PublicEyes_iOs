//
//  RegisterViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
        
        // Do any additional setup after loading the view.
    }
    
    func clickBack(_ sender:UIButton!){
        HPZMainFrame.showFirstVC()
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
    
    @IBAction func showPassword(_ sender: UIButton) {
    }

    @IBAction func registerAcc(_ sender: UIButton) {
        HPZMainFrame.showHomeVC()
    }
    
}
