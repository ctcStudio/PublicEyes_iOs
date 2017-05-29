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

    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
    }
    
    func clickBack(_ sender:UIButton!){
        HPZMainFrame.showFirstVC()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showPassword(_ sender: Any) {
    }
    
    @IBAction func loginByEmail(_ sender: Any) {
        //HPZMainFrame.showHomeVC()
        let email = etEmail.text
        let password = etPassword.text
        self.login(email:email!, password:password!)
    }
    
    func login(email:String, password:String) {
        if(email.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Alert", message: "Bạn chưa nhập đủ thông tin email và password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let params = NSMutableDictionary.init();
        params.setObject(email, forKey: "email" as NSCopying)
        params.setObject(password,forKey: "password" as NSCopying)
        HPZWebservice.shareInstance.loginWithEmail(path:API_LOGIN,params:params,handler:{success , response in
            if(success) {
                if(response?.isKind(of: HPZLoginEntity.self))!{
                    let loginEntity:HPZLoginEntity = response as! HPZLoginEntity
                    if(loginEntity.code == 0) {
                        HPZMainFrame.showSliderVC()
                        userDefault.setValue(email, forKey: UserDefault_email)
                        userDefault.setValue(password, forKey: UserDefault_password)
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: loginEntity.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:HPZLoginEntity(), isAthen:false)

    }
    
    @IBAction func loginByFacebook(_ sender: Any) {
        self.pLoginWithFacebook()
    }
    
}


extension HPZLoginViewController {
    
    // MARK: Facebook
    
    func pLoginWithFacebook() -> Void {
        
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
                            
            }
        }
    }
    
    func fetchFacebookUserInfo ()-> Void
    {
        if (FBSDKAccessToken.current() != nil)
        {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, first_name, last_name, email, birthday, location ,friends ,hometown"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if let error = error {
                    print("Error: \(error)")
                } else {
                    let userName = (result as! NSDictionary).value(forKey: "name")
                    let userID = (result as! NSDictionary).value(forKey: "id")
                    print("facebook acc: %s id: %s", userName ?? "", userID ?? "")
                    self.login(email: userName as! String, password: userID as! String)
                }
            })
        }
    }
    

}
