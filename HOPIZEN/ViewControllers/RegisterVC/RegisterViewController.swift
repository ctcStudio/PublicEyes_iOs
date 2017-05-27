//
//  RegisterViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    var email:String?
    var password: String?
    var fullName: String?
    var idNumber: String?
    var mobilePhone: String?
    var address: String?
    
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etPhone: UITextField!
    @IBOutlet weak var etIdNumber: UITextField!
    @IBOutlet weak var etAddress: UITextField!

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
        email = etEmail.text ?? ""
        password = etPassword.text ?? ""
        fullName = etName.text ?? ""
        mobilePhone = etPhone.text ?? ""
        idNumber = etIdNumber.text ?? ""
        address = etAddress.text ?? ""
        register()
    }
    
    func register() {
        if((email?.isEmpty)! || (password?.isEmpty)! || (mobilePhone?.isEmpty)! || (fullName?.isEmpty)!) {
            let alert = UIAlertController(title: "Alert", message: "Bạn phải nhập đủ thông tin email, password, họ tên và số điện thoại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let params = NSMutableDictionary.init();
        params.setObject(email ?? "", forKey: "email" as NSCopying)
        params.setObject(password ?? "",forKey: "password" as NSCopying)
        params.setObject(fullName ?? "", forKey: "name" as NSCopying)
        params.setObject(mobilePhone ?? "",forKey: "mobile_phone" as NSCopying)
        params.setObject(idNumber ?? "", forKey: "id_card" as NSCopying)
        params.setObject(address ?? "",forKey: "address" as NSCopying)
        HPZWebservice.shareInstance.registerUser(path:API_RESGISTER,params:params,handler:{success , response in
            if(success) {
                if(response?.isKind(of: HPZMessageModel.self))!{
                    let message:HPZMessageModel = response as! HPZMessageModel
                    if(message.code == 0) {
                        HPZMainFrame.showSliderVC()
                        userDefault.setValue(self.email, forKey: UserDefault_email)
                        userDefault.setValue(self.password, forKey: UserDefault_password)
                        userDefault.set(true, forKey: UserDefault_fist_login)
                        return
                    }
                    else {
                        let alert = UIAlertController(title: "Alert",message: message.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:HPZMessageModel(), isAthen:false)
        
    }
}
