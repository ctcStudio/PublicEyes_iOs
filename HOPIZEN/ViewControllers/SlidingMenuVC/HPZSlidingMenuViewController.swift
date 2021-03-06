//
//  HPZSlidingMenuViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

class HPZSlidingMenuViewController: UIViewController, PopupDelegate {

    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvPoint: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestUpdatePoint()
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
        let point = userDefault.value(forKey: UserDefault_point) as! Int
        if(point < NUMBER_COIN_CHANGE) {
            let alert = UIAlertController(title: "Alert", message: String.init(format: "Bạn phải có ít nhất %d point mới thực hiện chức năng này", NUMBER_COIN_CHANGE), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let popup = PopupChangePoint.init(nibName: "PopupChangePoint", bundle: nil);
        popup.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func changePoint(phone: String) {
        if(phone.isEmpty) {
            return
        }
        SVProgressHUD.show()
        let userNoPhone = "0"+phone;
        let param = [
            "phone":userNoPhone,
            "point":userDefault.string(forKey: UserDefault_point) ?? "0"
        ] as [String : Any]
        HPZWebservice.shareInstance.convertPoint(path:API_CONVERT_COIN,params: param as NSDictionary,handler:{success , response in
            SVProgressHUD.dismiss()
            if(success) {
                if(response?.isKind(of: ConvertPointModel.self))!{
                    let convertPoint:ConvertPointModel = response as! ConvertPointModel
                    if(convertPoint.code == 0) {
                        userDefault.set("",forKey: UserDefault_TRANS_ID)
                        userDefault.set(0,forKey: UserDefault_TRANS_POINT)
                        self.tvPoint.text = String.init(describing: convertPoint.point)
                        userDefault.set(self.tvPoint.text, forKey: UserDefault_point)
                        
                        let alert = UIAlertController(title: "Alert", message: "Chuyển point Thành công", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Chuyển point thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:ConvertPointModel())
        
    }
//    
//    func changePoint(phone: String) {
//        if(phone.isEmpty) {
//            return
//        }
//        let userNoPhone = "+84"+phone;
//        SVProgressHUD.show()
//        let param = [
//            "transRef":getUnixtime(),
//            "userNophone": userNoPhone,
//            "amount":userDefault.string(forKey: UserDefault_point),
//            "callback_data":"convertPoinIOS"
//            
//        ]
//        HPZWebservice.shareInstance.getSendOrder(path:API_COIN_SEND,params: param as NSDictionary,handler:{success , response in
//            SVProgressHUD.dismiss()
//            if(success) {
//                if(response?.isKind(of: OrderModel.self))!{
//                    let order:OrderModel = response as! OrderModel
//                    if(order.status == COIN_SUCCESS) {
//                        userDefault.set(order.sendOrderId, forKey: UserDefault_TRANS_ID)
//                        userDefault.set(order.amount, forKey: UserDefault_TRANS_POINT)
//                        
//                        self.requestUpdatePoint()
//                        return
//                    }
//                }
//            }
//            let alert = UIAlertController(title: "Alert", message: "Chuyển point thất bại", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            
//        }, entity:OrderModel())
//        
//    }
//    
    func requestUpdatePoint() -> Void {
        let transactionId = userDefault.value(forKey: UserDefault_TRANS_ID) as? String
        if((transactionId == nil) || (transactionId?.isEmpty)!) {
            return
        }
        let point = userDefault.value(forKey: UserDefault_TRANS_POINT) as! Int
        let param = [
            "transcation_id":(transactionId) ?? "",
            "point": (point)
            
        ] as [String : Any]
        HPZWebservice.shareInstance.updatePoint(path:API_UPDATE_POINT,params: param as NSDictionary,handler:{success , response in
            let msg = response as! HPZMessageModel
            if(success && msg.code == PAY_SUCCESS) {
                userDefault.set("",forKey: UserDefault_TRANS_ID)
                userDefault.set(0,forKey: UserDefault_TRANS_POINT)
                self.tvPoint.text = "0"
                userDefault.set(0, forKey: UserDefault_point)
                return
            }
            
            let alert = UIAlertController(title: "Alert", message: msg.message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:HPZMessageModel())
    }
    
}
