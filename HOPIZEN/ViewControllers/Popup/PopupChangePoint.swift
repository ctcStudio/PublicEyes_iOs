//
//  PopupChangePoint.swift
//  PublicEyes
//
//  Created by hunghoang on 8/5/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

@objc protocol PopupDelegate {
    func changePoint(phone:String)
    @objc optional func cancelChange()
}

class PopupChangePoint: UIViewController, UITextViewDelegate {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var tvPhone: UITextField!
    var delegate:PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // You must set the formatting of the link manually
        viewBg.layer.cornerRadius = 10.0
        
        let linkAttributes = [
            NSLinkAttributeName: NSURL(string: COIN_REG_LINK)!,
            NSForegroundColorAttributeName: UIColor.blue,
            ] as [String : Any]
        let startContent = "Nếu bạn chưa có tài khoản hay bấm "
        let linkContent = "đây"
        let endContent = " để đăng ký tài khoản.\nNếu bạn có tài khoản thì hãy nhập số điện thoại để chuyển point thành gCoin"
        let content = startContent + linkContent + endContent
        let attributedString = NSMutableAttributedString(string: content)
        
        let fontAttibutes = [
            NSFontAttributeName: UIFont(name: "Arial", size: 18.0)!,
            NSForegroundColorAttributeName: UIColor.white,
            ] as [String : Any]
        attributedString.setAttributes(fontAttibutes, range: NSMakeRange(0, content.length()))
        
        // Set the 'click here' substring to be the link
        let start = startContent.length()
        let length = linkContent.length()
        attributedString.addAttributes(linkAttributes, range: NSMakeRange(start, length))
        
        self.tvContent.delegate = self
        self.tvContent.attributedText = attributedString
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changePoint(_ sender: Any) {
        self.dismiss()
        delegate?.changePoint(phone: tvPhone.text!)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss()
    }
    
    public func dismiss(_ completion: (() -> Void)? = nil) {
        self.dismiss(animated: true) {
            completion?()
        }
    }

}
