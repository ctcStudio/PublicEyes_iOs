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

class HPZMainFrame: NSObject {
    static func makeNewMainFrame () -> UIViewController! {
        let center = self.makeCenterNavi()
        let left = self.makeSideMenu()
        mainFrame = UISidebarViewController(center: center, andSidebarViewController: left)
        mainFrame!.sidebarWidth = screenWidth * 0.85
        // update layout
        
        mainFrame?.sidebarVC.view.frame = CGRect(x: CGFloat(left.view.frame.origin.x), y:                                                      CGFloat(left.view.frame.origin.y), width: CGFloat(screenWidth), height: CGFloat(screenHeight))
        
        left.view.layoutIfNeeded()
        return mainFrame
    }
    
    
    static func makeSideMenu () -> HPZSlidingMenuViewController {
        let sideMenu:HPZSlidingMenuViewController = HPZSlidingMenuViewController(nibName: "HPZSlidingMenuViewController", bundle: nil)
        return sideMenu
    }
    
    static func makeCenterNavi () -> UINavigationController {// 84 86 172
        let naviRoot = HPZHomeViewController(nibName: "HPZHomeViewController", bundle: nil)
        let navi = HPZCutomNavigationController(rootViewController: naviRoot)
        navi.addLeftBtnWithBackgroundImage(bgImg: UIImage(named: "menu"), title: "", titleColor: UIColor.black, targer: self, action: #selector(HPZMainFrame.menuBtnTouched(sender:)))
        navi.navigationBar.isTranslucent = false
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
    
    static func showHomeVC() -> Void {
        let vc = HPZHomeViewController(nibName: "HPZHomeViewController", bundle: nil)
        (mainFrame?.centerVC as! UINavigationController).viewControllers = [vc]
        
    }
    static func getNavi() -> HPZCutomNavigationController{
        let navi = mainFrame?.centerVC as! HPZCutomNavigationController
        return navi
    }
    
    static func addMenuBtn() -> Void {
        self.getNavi().addLeftBtnWithBackgroundImage(bgImg: UIImage(named: "menu"), title: "", titleColor: UIColor.black, targer: self, action: #selector(HPZMainFrame.menuBtnTouched(sender:)))
    }
}
