//
//  HPZSlidingMenuViewController.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit
import PopupDialog

class HPZSlidingMenuViewController: UIViewController, PopupDelegate {

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
        let popup = PopupChangePoint.init(nibName: "PopupChangePoint", bundle: nil);
        popup.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func changePoint(phone: String) {
        if(phone.isEmpty) {
            return
        }
        let userNoPhone = "+84"+phone;
        SVProgressHUD.show()
        let param = [
            "transRef":getUnixtime(),
            "userNophone": userNoPhone,
            "amount":userDefault.string(forKey: UserDefault_point),
            "callback_data":"convertPoinIOS"
            
        ]
        HPZWebservice.shareInstance.getSendOrder(path:API_COIN_SEND,params: param as NSDictionary,handler:{success , response in
            SVProgressHUD.dismiss()
            if(success) {
                if(response?.isKind(of: OrderModel.self))!{
                    let order:OrderModel = response as! OrderModel
                    if(order.status == COIN_SUCCESS) {
                        userDefault.set(order.sendOrderId, forKey: UserDefault_TRANS_ID)
                        
                        return
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Chuyển point thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:OrderModel())
        
    }
    
}
