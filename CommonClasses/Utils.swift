//
//  LandingPageVC.swift
//  TalabService
//
//  Created by bhavin on 12/03/19.
//  Copyright © 2019 bhavin. All rights reserved.
//


import UIKit
import Foundation
import SystemConfiguration
import IHProgressHUD

class Utils: NSObject {
    func height(forText text: String?, font: UIFont?, withinWidth width: CGFloat) -> CGFloat {
        
        let constraint = CGSize(width: width, height: 20000.0)
        var size: CGSize
        var boundingBox: CGSize? = nil
        if let aFont = font {
            boundingBox = text?.boundingRect(with: constraint, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: aFont], context: nil).size
        }
        size = CGSize(width: ceil((boundingBox?.width)!), height: ceil((boundingBox?.height)!))
        return size.height
    }
    
    public static func popDialog(controller: UIViewController, title:String, message: String){
        let dialog = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        dialog.addAction(objAction)
        controller.present(dialog, animated: true, completion: nil)
    }
    func showMessage(_ message: String)
    {
        SKToast.show(withMessage: "\(message)        ")
        SKToast.backgroundStyle(.dark)
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func getloggedinUserDict() -> [AnyHashable: Any]?
    {
        let dictionaryData = UserDefaults.standard.object(forKey: "LoggedInUserDict") as? Data
        var dictionary: [AnyHashable: Any]? = nil
        if let aData = dictionaryData {
            dictionary = NSKeyedUnarchiver.unarchiveObject(with: aData) as? [AnyHashable: Any]
        }
        return dictionary
    }
    
    func getItemDetailata() -> [AnyHashable: Any]?
    {
        let dictionaryData = UserDefaults.standard.object(forKey: "ItemDetailDict") as? Data
        var dictionary: [AnyHashable: Any]? = nil
        if let aData = dictionaryData {
            dictionary = NSKeyedUnarchiver.unarchiveObject(with: aData) as? [AnyHashable: Any]
        }
        return dictionary
    }
    
    func resizeImage(image: UIImage) -> UIImage
    {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.8
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        //let imageData = UIImageJPEGRepresentation(img!, CGFloat(compressionQuality))
        
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }
    
    func ShowLoader(){
        IHProgressHUD.show()
        IHProgressHUD.set(defaultStyle: .light)
        
    }
    
    func HideLoader(){
        DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            IHProgressHUD.dismiss()
        })
    }
    
    func convertToTimeslot(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy h a"
        let myString = formatter.date(from:date)
        formatter.dateFormat = "h:mm a"
        let myStringafd = formatter.string(from: myString!)
        return myStringafd
    }
}
