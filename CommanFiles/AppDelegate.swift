//
//  AppDelegate.swift
//  CommanFiles
//
//  Created by bhavin joshi on 27/01/20.
//  Copyright © 2020 bhavin joshi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
//
//        var cell = tableView.dequeueReusableCell(withIdentifier: "TrackOrderCell") as? TrackOrderCell
//               if cell == nil {
//                   let nib = Bundle.main.loadNibNamed("TrackOrderCell", owner: self, options: nil)
//                   cell = nib?[0] as? TrackOrderCell
//               }
//               cell?.layer.shouldRasterize = true
//               cell?.layer.rasterizationScale = UIScreen.main.scale
//               cell?.selectionStyle = .none
//
        
    //self.collectionViewProducts.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
        
    //    let cell: ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        
        //        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesListVC") as? CategoriesListVC
        //        self.navigationController?.isNavigationBarHidden = false
        //        self.navigationController?.pushViewController(vc!, animated: true)

    
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func setRootView() {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//        let leftViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
//
//        let navigationController = UINavigationController(rootViewController: rootViewController!)
//        navigationController.isNavigationBarHidden = true // or not, your choice.
//
//        let sideMenuController = LGSideMenuController(rootViewController: navigationController,
//                                                      leftViewController: leftViewController,
//                                                      rightViewController: nil)
//
//        if(Device.DeviceType.IS_IPHONE_5_OR_LESS){
//            sideMenuController.leftViewWidth = (UIApplication.shared.windows.first?.rootViewController?.view.frame.size.width)! - 80
//        }
//        else{
//            sideMenuController.leftViewWidth = (UIApplication.shared.windows.first?.rootViewController?.view.frame.size.width)! - 100
//        }
//
//        sideMenuController.leftViewPresentationStyle = .slideAbove
//
//        UIApplication.shared.windows.first?.rootViewController = sideMenuController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

