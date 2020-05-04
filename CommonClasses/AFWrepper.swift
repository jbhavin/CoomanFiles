//
//  AFWrepper.swift
//  OfferTreat
//
//  Created by bhavin on 15/05/18.
//  Copyright © 2018 bhavin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AFWrapper: NSObject
{
    
    class func postMethod (params: [String : AnyObject], apikey: String, completion: @escaping (Any) -> Void, failure:@escaping (Error) -> Void)
    {
        if Utils().isConnectedToNetwork() == false{
            Utils().showMessage(Constants.NetworkUnavailable)
            Utils().HideLoader()
            return
        }
        
        print(params)
        print(apikey)
        
        let strURL = Constants.BASE_URL + apikey
        let url = URL(string: apikey)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(url!, method: .post, parameters: params)
            .validate().responseJSON
            {
                response in
                switch (response.result)
                {
                case .success:
                    let jsonResponse = response.result.value as! NSDictionary
                    print(jsonResponse)
                    completion(jsonResponse)
                    Utils().HideLoader()
                case .failure(let error):
                    Utils().showMessage("Somethingwentwrong")
                    Utils().HideLoader()
                    failure(error)
                    
                    break
                }
        }
    }
    
    class func GetMethod (params: [String : AnyObject], apikey: String, completion: @escaping (Any) -> Void, failure:@escaping (Error) -> Void)
    {
        if Utils().isConnectedToNetwork() == false
        {
            Utils().showMessage(Constants.NetworkUnavailable)
            return
        }
        
        //Utils().ShowLoader()
        let strURL = Constants.BASE_URL + apikey
        let url = URL(string: strURL)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(url!, method: .get, parameters: params)
            .responseJSON
            {
                response in
                
                switch (response.result)
                {
                case .success:
                    
                    //do json stuff
                    let jsonResponse = response.result.value as! NSDictionary
                    print(jsonResponse)
                    completion(jsonResponse)
                    Utils().HideLoader()
                    
                case .failure(let error):
                    
                    Utils().showMessage("Somethingwentwrong")
                    failure(error)
                    Utils().HideLoader()
                    break
                }
        }
    }
    

    
    class func postMultiPartdata (params: [String : AnyObject], apikey: String, completion: @escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        
        if Utils().isConnectedToNetwork() == false
        {
            Utils().showMessage(Constants.NetworkUnavailable)
            return
        }
        
        //Utils().ShowLoader()
        let strURL = Constants.BASE_URL + apikey
        let url = URL(string: strURL)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                //    multipartFormData.append(imageData, withName: "user", fileName: "user.jpg", mimeType: "image/jpeg")
                
                for (key, value) in params {
                    
                    if value is Data{
                        let r = arc4random()
                        let filename = "user\(r).jpg"
                        let imgData = params[key] as! Data
                        MultipartFormData.append(imgData, withName: "image", fileName: filename, mimeType: "image/jpeg")
                    }
                    else{
                        MultipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                    
                }
        }, to: url!) { (result) in
            
            switch (result)
            {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    print(response)
                    let jsonResponse = response.result.value as! NSDictionary
                    print(jsonResponse)
                    completion(jsonResponse)
                    Utils().HideLoader()
                    
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    class func postMultiPartdata1 (params: [String : AnyObject], apikey: String, completion: @escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        
        if Utils().isConnectedToNetwork() == false
        {
            Utils().showMessage(Constants.NetworkUnavailable)
            return
        }
        
        Utils().ShowLoader()
        
        let strURL = Constants.BASE_URL + apikey
        
        let url = URL(string: strURL)
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        let body:NSMutableData=NSMutableData()
        let boundry:NSString="---------------------------14737809831466499882746641449"
        let contentType:NSString=NSString(format: "multipart/form-data; boundary=%@", boundry)
        
        request .setValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        for (key, value) in params {
            
            if value is String
            {
                //body.append("Content-Type: text/html" .data(using: String.Encoding.utf8)!)
                body.append("--\(boundry)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(params[key] as! String)".data(using: String.Encoding.utf8)!)
                body.append("\r\n".data(using: String.Encoding.utf8)!)
            }
            else if key == "profile_image" {
                
                let imgData2 = params[key]
    
                let imgCompressed: UIImage? = Utils().resizeImage(image: imgData2 as! UIImage)
                let imageData = imgCompressed?.pngData()
                let imgData = imageData as! Data
                
                let r = arc4random()
                let filename = "image\(r).jpg"
                let mimetype = "image/jpg"
                
                body.append("--\(boundry)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)[]\"; filename=\"\(filename)\"\r\n" .data(using: String.Encoding.utf8)!)
                body.append("Content-Type: \(mimetype)\r\n\r\n" .data(using: String.Encoding.utf8)!)
                body.append(imgData as Data)
                body.append("\r\n" .data(using: String.Encoding.utf8)!)
                
                
            }else if value is NSMutableArray{
                
                let imageArray = NSMutableArray()
                imageArray.addObjects(from: params[key] as! [Any])
                
                for i in 0 ..< imageArray.count {
                    
                    let r = arc4random()
                    let filename = "image\(r).jpg"
                    let imgData = imageArray.object(at: i) as! Data
                    let mimetype = "image/jpg"
                    
                    body.append("--\(boundry)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)[]\"; filename=\"\(filename)\"\r\n" .data(using: String.Encoding.utf8)!)
                    body.append("Content-Type: \(mimetype)\r\n\r\n" .data(using: String.Encoding.utf8)!)
                    body.append(imgData as Data)
                    body.append("\r\n" .data(using: String.Encoding.utf8)!)
                }
            }
            
        }
        
        if let anEncoding = "--\(boundry)--\r\n".data(using: .utf8) {
            body.append(anEncoding)
        }
        // setting the body of the post to the reqeust
        request.httpBody = body as Data
        
        var dataTask: URLSessionDataTask? = nil
        
        dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            
            var dictonary:NSDictionary?
            do {
                
                if data == nil{
                    completion("")
                }else{
                    dictonary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                    if let myDictionary = dictonary
                    {
                        print(myDictionary)
                        completion(myDictionary)
                    }
                }
                
            } catch let error as NSError {
                
                Utils().showMessage("Somethingwentwrong".localized())
                failure(error)
                print(error.description)
            }
            
            Utils().HideLoader()
        })
        
        dataTask?.resume()
    }
    
}

/*
 
 private var APIManager : Alamofire.SessionManager = {
 // Create the server trust policies
 let serverTrustPolicies: [String: ServerTrustPolicy] = [
 "talabservice.com": .disableEvaluation
 ]
 // Create custom manager
 let configuration = URLSessionConfiguration.default
 configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
 let man = Alamofire.SessionManager(
 configuration: URLSessionConfiguration.default,
 serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
 )
 return man
 }()

 
 */
