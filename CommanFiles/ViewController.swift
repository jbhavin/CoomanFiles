//
//  ViewController.swift
//  CommanFiles
//
//  Created by bhavin joshi on 27/01/20.
//  Copyright © 2020 bhavin joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var range = NSRange()
    @IBOutlet weak var lbldata: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callapi()
        // Do any additional setup after loading the view.
    }
    
    func callapi(){
         let parameters = ["lng":"en","type":"gold"]
        AFWrapper.postMethod(params: parameters as [String : AnyObject], apikey: "http://3.0.203.214/api/web/tumi/users/membershipprivilages", completion: { (json) in
            let dict = json as! NSDictionary
            
            if dict["status"] as? Int == 1
            {
                DispatchQueue.main.async{
                    
                    let dataDict = dict.value(forKey: "data") as! NSDictionary
                    let strContent = dataDict.value(forKey: "text") as! String
                    let modifiedFont = NSString(format:"<span style=\"font-family: \(UIFont.systemFont(ofSize: 15)); font-size: \(15)\">%@</span>" as NSString, strContent)
                    let encodedData = modifiedFont.data(using: String.Encoding.utf8.rawValue)!
                    
                    var attributedString: NSAttributedString
                    
                    do {
                        attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
                        
                        attributedString.enumerateAttribute(NSAttributedString.Key.link , in: NSMakeRange(0, attributedString.length), options: [.longestEffectiveRangeNotRequired]) { value, range, isStop in
                            if let value = value {
                                print("\(value) found at \(range.location)")
                                self.range = NSRange(location: range.location - 50, length: range.length + 50)
                            }
                        }
                        
                        self.lbldata.font = UIFont(name: Constants.FONT, size: 16)
                        self.lbldata?.attributedText = attributedString
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    } catch {
                        print("error")
                    }
                    self.lbldata?.numberOfLines = 0
                }
            }
            

        }, failure: { (error) in
            
            print(error)
        })
    }


}

