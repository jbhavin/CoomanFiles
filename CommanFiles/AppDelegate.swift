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
        
        
        
        @IBAction func btnEventGalleryTapped(_ sender: Any) {
                let vc = BSImagePickerViewController()
                vc.maxNumberOfSelections = 3
                
                bs_presentImagePickerController(vc, animated: true,
                                                select: { (asset: PHAsset) -> Void in
                                                    // User selected an asset.
                                                    // Do something with it, start upload perhaps?
                }, deselect: { (asset: PHAsset) -> Void in
                    // User deselected an assets.
                    // Do something, cancel upload?
                }, cancel: { (assets: [PHAsset]) -> Void in
                    // User cancelled. And this where the assets currently selected.
                }, finish: { (assets: [PHAsset]) -> Void in
                    // User finished with these assets
                    //            print("Finish: \(assets)")
                    //            print("Finish1: \(assets[0])")
                    //            let img1 = self.getAssetThumbnail(asset: assets[0])
                    //            self.image1.image = img1
                    //            let img2 = self.getAssetThumbnail(asset: assets[1])
                    //            self.image2.image = img2
                    //            let img3 = self.getAssetThumbnail(asset: assets[2])
                    //            self.image3.image = img3
                    //            print("Finish2: \(assets[1])")
                    //            print("Finish3: \(assets[2])")
                    
                    self.arrImageData.removeAll()
                    self.imgArray.removeAll()
                    
                    if assets.count == 1{
                        let img1 = self.getAssetThumbnail(asset: assets[0])
                        let data1 = img1.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data1!)
                        self.fileName.append("File1")
                    }
                    else if assets.count == 2{
                        let img1 = self.getAssetThumbnail(asset: assets[0])
                        let data1 = img1.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data1!)
                        
                        let img2 = self.getAssetThumbnail(asset: assets[1])
                        let data2 = img2.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data2!)
                        self.fileName.append("File1,File2")
                    }
                    else if assets.count == 3{
                        let img1 = self.getAssetThumbnail(asset: assets[0])
                        let data1 = img1.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data1!)
                        
                        let img2 = self.getAssetThumbnail(asset: assets[1])
                        let data2 = img2.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data2!)
                        
                        let img3 = self.getAssetThumbnail(asset: assets[2])
                        let data3 = img3.jpegData(compressionQuality: 0.1)
                        self.arrImageData.append(data3!)
                        self.fileName.append("File1,File2,File3")
                    }
                    
                    for i in 0..<assets.count{
                        let img1 = self.getAssetThumbnail(asset: assets[i])
                        
                        self.imgArray.append(img1)
                    }
                    
                    if self.imgArray.count > 2{
                        self.imgCollectionViewHeight.constant = 320
                    }
                    else{
                        self.imgCollectionViewHeight.constant = 150
                    }
                    
                    self.viewAddGallery.isHidden = true
                    self.collectionViewImage.delegate = self
                    self.collectionViewImage.dataSource = self
                    self.collectionViewImage.reloadData()
                }, completion: nil)
            }

        func getAssetThumbnail(asset: PHAsset) -> UIImage {
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                return thumbnail
            }
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("bhavin.scandemo.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
    }

    // If you support iOS 8, add the following method.
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("bhavin.scandemo.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication)
        }
        return false
    }
}

