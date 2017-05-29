//
//  HPZMainFrame.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit
import UISidebarViewController

var mainFrame:UISidebarViewController?
var navigationView:HPZCutomNavigationController?

class HPZMainFrame: NSObject {
    static func makeNewMainFrame (isLogin:Bool) -> UIViewController! {
        if(isLogin) {
            navigationView = self.makeSliderNavi()
            let left = self.makeSideMenu()
            mainFrame = UISidebarViewController(center: navigationView, andSidebarViewController: left)
            mainFrame!.sidebarWidth = screenWidth * 0.85
            // update layout
            mainFrame?.sidebarVC.view.frame = CGRect(x: CGFloat(left.view.frame.origin.x), y: CGFloat(left.view.frame.origin.y), width: CGFloat(screenWidth), height: CGFloat(screenHeight))
            
            left.view.layoutIfNeeded()
            return mainFrame;
            
        } else {
            navigationView = self.makeNoSliderNavi()
            return navigationView;
            
        }
    }
    
    
    static func makeSideMenu () -> HPZSlidingMenuViewController {
        let sideMenu:HPZSlidingMenuViewController = HPZSlidingMenuViewController(nibName: "HPZSlidingMenuViewController", bundle: nil)
        return sideMenu
    }
    
    static func makeSliderNavi () -> HPZCutomNavigationController {
        let naviRoot = HPZHomeViewController(nibName: "HPZHomeViewController", bundle: nil)
        let navi = HPZCutomNavigationController(rootViewController: naviRoot)
        navi.navigationBar.isHidden = false;
        navi.navigationBar.isTranslucent = true
        navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        
        return navi
    }
    
    static func makeNoSliderNavi () -> HPZCutomNavigationController {
        let naviRoot = FirstViewController(nibName: "FirstViewController", bundle: nil)
        let navi = HPZCutomNavigationController(rootViewController: naviRoot)
        navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        navi.navigationBar.isTranslucent = true
        return navi
    }
    
    static func hidenMenu() {
        if mainFrame?.sidebarIsShowing == true {
            mainFrame!.toggleSidebar(nil)
        }
    }
    
    static func showMenu() {
        if mainFrame?.sidebarIsShowing == false {
            mainFrame!.toggleSidebar(nil)
        }
    }
    
    static func menuBtnTouched(sender:UIButton!){
        mainFrame!.toggleSidebar(nil)
    }
    
    static func showFirstVC() -> Void {
        let vc = FirstViewController(nibName: "FirstViewController", bundle: nil)
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            navigationView?.navigationBar.isHidden = false;
            navigationView?.navigationBar.isTranslucent = true
            navigationView?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationView?.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        mainFrame = nil
    }
    
    static func showSliderVC() -> Void {
        if(userDefault.bool(forKey: UserDefault_fist_login) == true) {
            let vc = SliderViewController(nibName: "SliderViewController", bundle: nil)
            (navigationView!).viewControllers = [vc]
             navigationView?.navigationBar.isHidden = true;
        } else {
            showHomeVC()
        }
    }
    
    static func showHomeVC() -> Void {
        let navi = self.makeSliderNavi()
        let left = self.makeSideMenu()
        mainFrame = UISidebarViewController(center: navi, andSidebarViewController: left)
        mainFrame!.sidebarWidth = screenWidth * 0.85
        // update layout
        mainFrame?.sidebarVC.view.frame = CGRect(x: CGFloat(left.view.frame.origin.x), y: CGFloat(left.view.frame.origin.y), width: CGFloat(screenWidth), height: CGFloat(screenHeight))
        
        left.view.layoutIfNeeded()
        
        UIApplication.shared.keyWindow!.rootViewController = mainFrame
        navigationView = nil;
    }
    
    static func showReportPhoto(image:UIImage) -> Void {
        let vc = ReportPhotoViewController(nibName: "ReportPhotoViewController", bundle: nil)
        vc.image = image;
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)
        mainFrame = nil;
    }
    
    static func showReportVideo(videoUrl:NSURL) -> Void {
        let vc = ReportVideoViewController(nibName: "ReportVideoViewController", bundle: nil)
        vc.videoUrl = videoUrl;
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)

        mainFrame = nil;
    }
    
    static func showCategoryPhoto(image:UIImage, path:String!, des:String) -> Void {
        let vc = CategoryTableViewController(nibName: "CategoryTableViewController", bundle: nil)
        vc.image = image
        vc.path = path
        vc.des = des
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)

        mainFrame = nil;
    }
    
    static func showCategoryVideo(videoUrl:NSURL, path:String!, des:String) -> Void {
        let vc = CategoryTableViewController(nibName: "CategoryTableViewController", bundle: nil)
        vc.videoUrl = videoUrl
        vc.path = path
        vc.des = des
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)

        mainFrame = nil;
    }
    
    static func showLocation(category:CategoryModel!, path:String!, des:String) -> Void {
        let vc = LocationViewController(nibName: "LocationViewController", bundle: nil)
        vc.category = category
        vc.path = path
        vc.des = des
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)

        mainFrame = nil;
    }
    
    static func showMenuIcon() -> Void {
        getNavi().navigationBar.isTranslucent = true;
        getNavi().navigationBar.isHidden = false;
        getNavi().addLeftBtnWithBackgroundImage(bgImg: UIImage(named: "menu"), title: "", titleColor: UIColor.black, targer: self, action: #selector(HPZMainFrame.menuBtnTouched(sender:)))
    }
    
    static func showRegisterVC() -> Void {
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        (navigationView!).viewControllers = [vc]
    }
    
    static func showLoginVC() -> Void {
        let vc = HPZLoginViewController(nibName: "HPZLoginViewController", bundle: nil)
        (navigationView!).viewControllers = [vc]
    }
    
    /*
    static func showMyComplaintVC() -> Void {
        let vc = ComplaintTableViewController(nibName: "ComplaintTableViewController", bundle: nil)
        (mainFrame?.centerVC as! HPZCutomNavigationController).viewControllers = [vc]
    }
     */
    static func showMyComplaintVC() -> Void {
        let vc = ComplaintTableViewController(nibName: "ComplaintTableViewController", bundle: nil)
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)

        mainFrame = nil;
    }
    
    static func showCampaignVC() -> Void {
        let vc = NewsTableViewController(nibName: "NewsTableViewController", bundle: nil)
//        (mainFrame?.centerVC as! HPZCutomNavigationController).viewControllers = [vc]
        if(navigationView == nil){
            navigationView = HPZCutomNavigationController(rootViewController: vc)
            //navigationView?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            //navigationView?.navigationBar.shadowImage = UIImage()
        
            UIApplication.shared.keyWindow!.rootViewController = navigationView
        } else {
            (navigationView!).viewControllers = [vc]
        }
        navigationView?.navigationBar.isHidden = false;
        navigationView?.navigationBar.isTranslucent = false
        navigationView?.navigationBar.backgroundColor = UIColor(netHex: 0x3c3f41)
        mainFrame = nil;

    }
    
    static func updateLeftMenu(userInfo: HPZUserModel) -> Void {
        if(mainFrame != nil) {
            (mainFrame?.sidebarVC as! HPZSlidingMenuViewController).updateInfo(userInfo: userInfo)
        }
    }
    
    
    static func getNavi() -> HPZCutomNavigationController{
        if(mainFrame != nil) {
            return mainFrame?.centerVC as! HPZCutomNavigationController
        } else {
            return navigationView!
        }
    }
    
    static func addMenuLeft(title:String, titleColor: UIColor?, target:AnyObject?, action: Selector) {
        self.getNavi().addLeftBtnWithTitle(title: title, titleColor: titleColor, target: target, action: action)
    }
    
    static func addMenuRight(title:String, titleColor: UIColor?, target:AnyObject?, action: Selector) {
        self.getNavi().addRightBtnWithTitle(title: title, titleColor: titleColor, target: target, action: action)
    }
    
    static func addBackBtn(target:AnyObject?, action: Selector) -> Void {
        self.getNavi().addLeftBtnWithBackgroundImage(bgImg: UIImage(named: "back"), title: "", titleColor: UIColor.white, targer: target, action: action)
    }
    
    static func addMenuBtn() -> Void {
        self.getNavi().addLeftBtnWithBackgroundImage(bgImg: UIImage(named: "menu"), title: "", titleColor: UIColor.black, targer: self, action: #selector(HPZMainFrame.menuBtnTouched(sender:)))
    }
}
