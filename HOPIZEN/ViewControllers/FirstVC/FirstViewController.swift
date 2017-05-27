//
//  FirstViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    @IBAction func signUpByFB(_ sender: UIButton) {
        self.pLoginWithFacebook()
    }
    
    @IBAction func signUpByEmail(_ sender: UIButton) {
        HPZMainFrame.showRegisterVC()
    }
    
    @IBAction func loginToApp(_ sender: UIButton) {
        HPZMainFrame.showLoginVC()
    }
    
}

extension FirstViewController {
    
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
    
    func fetchFacebookUserInfo ()-> Void {
        if (FBSDKAccessToken.current() != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, first_name, last_name, email, birthday, location ,friends ,hometown"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if let error = error {
                    print("Error: \(error)")
                } else {
                    let userName = (result as! NSDictionary).value(forKey: "name")
                    let userID = (result as! NSDictionary).value(forKey: "id")
                    print("facebook acc:", userName ?? "", userID ?? "")
                    self.login(email: userName as! String, password: userID as! String)
                }
            })
        }
    }
    
    func login(email:String, password:String) {
        if(email.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Alert", message: "Xin lỗi, chúng tôi không thể kết nối tới facebook của bạn, hãy đăng ký bằng email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    HPZMainFrame.showHomeVC()
                    break
                case .cancel:
                    print("cancel")
                    HPZMainFrame.showHomeVC()
                    break
                case .destructive:
                    print("destructive")
                    HPZMainFrame.showHomeVC()
                    break
                }
            }))
            self.present(alert, animated: true, completion: nil)
            return
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
                    }
                }
            }
            HPZMainFrame.showRegisterVC()
            
        }, entity:HPZLoginEntity(), isAthen:false)
        
    }
}

