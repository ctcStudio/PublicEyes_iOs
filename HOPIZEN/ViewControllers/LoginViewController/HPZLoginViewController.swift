//
//  HPZLoginViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class HPZLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}


extension HPZLoginViewController {
    
    // MARK: Facebook
    
    private func pLoginWithFacebook() -> Void {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
        if FBSDKAccessToken.current() != nil {
            return
        }
        
        fbLoginManager.logIn(withReadPermissions: facebookReadPermissions, from: self) { (result, error) in
            if let error = error {
                print("error->\(error)")
                FBSDKLoginManager().logOut()
            } else if (result?.isCancelled)! {
                FBSDKLoginManager().logOut()
            } else {
                self.fetchFacebookUserInfo()
                let currentToken:String = FBSDKAccessToken.current().tokenString
                            
            }
        }
    }
    
    private func fetchFacebookUserInfo ()-> Void
    {
        if (FBSDKAccessToken.current() != nil)
        {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if let error = error {
                    print("Error: \(error)")
                } else {
                    let userName = (result as! NSDictionary).value(forKey: "name")
                    let userID = (result as! NSDictionary).value(forKey: "id")
                }
            })
        }
    }
    

}
