//
//  AppDelegate.swift
//  HOPIZEN
//
//  Created by Thuy Do Thanh on 12/13/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Facebook SDK
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
        IQKeyboardManager.sharedManager().enable = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let naviRoot = UIViewController.init()
        naviRoot.view.frame = (self.window?.bounds)!
        let img =  UIImageView(frame:(self.window?.bounds)!)
        img.image = UIImage.init(named: "bg_splash")
        naviRoot.view.addSubview(img)

        let navi = HPZCutomNavigationController(rootViewController: naviRoot)
        navi.navigationBar.isTranslucent = false
        navi.navigationBar.isHidden = true
        self.window!.rootViewController = navi
        self.window!.makeKeyAndVisible()
        
        UserDefaults.standard.register(defaults: [UserDefault_fist_login : true])
        // call api
        if(isActive()) {
            let userDefauts = UserDefaults.standard
            let email = userDefauts.string(forKey: UserDefault_email)
            let password = userDefauts.string(forKey: UserDefault_password);
            let params = NSMutableDictionary.init();
            params.setObject(email ?? "", forKey: "email" as NSCopying)
            params.setObject(password ?? "",forKey: "password" as NSCopying)
            HPZWebservice.shareInstance.loginWithEmail(path:API_LOGIN,params:params,handler:{success , response in
                if(success) {
                    if(response?.isKind(of: HPZLoginEntity.self))!{
                        let loginEntity:HPZLoginEntity = response as! HPZLoginEntity
                        if(loginEntity.code == 0) {
                            self.window!.rootViewController = HPZMainFrame.makeNewMainFrame(isLogin: true)
                            return
                        }
                    }
                }
                self.window!.rootViewController = HPZMainFrame.makeNewMainFrame(isLogin: false)
                
            }, entity:HPZLoginEntity(), isAthen:false)
        } else {
            self.window!.rootViewController = HPZMainFrame.makeNewMainFrame(isLogin: false)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    private func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // Add any custom logic here.
        return handled;
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if #available(iOS 9.0, *) {
            return self.application(application: app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplicationOpenURLOptionsKey.sourceApplication] as AnyObject)
        } else {
            // Fallback on earlier versions
            return true
        }
    }
    
    //
    //MARK - show main screen
    func showMainScreen() -> Void {
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = HPZMainFrame.makeNewMainFrame(isLogin: false)
        //self.window!.makeKeyAndVisible()
    }
    
    
    
    //    // MARK test
    //
    //
    //    func testJson() -> Void {
    //
    //
    //        do {
    //
    //            if let path = Bundle.main.path(forResource: "mappingJson", ofType: "geojson") {
    //                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    //                let rs = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
    //                print("rs ->>\(rs)")
    //            }
    //
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //        
    //
    //    }
    
}

