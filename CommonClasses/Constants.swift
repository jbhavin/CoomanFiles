//
//  LandingPageVC.swift
//
//  Created by bhavin on 12/03/19.
//  Copyright © 2019 bhavin. All rights reserved.
//


import Foundation
import UIKit

class Constants {
    public static let AppColor = (UIColor(red: 231.0/255.0, green: 39.0/255.0, blue: 45.0/255.0, alpha: 1.0))
    
    public static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    public static let USERDEFAULTS = UserDefaults.standard
    public static let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    public static let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
    public static let TrackOrderStoryboard = UIStoryboard(name: "TrackOrder", bundle: nil)
    public static let ProfileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    public static let WalletStoryboard = UIStoryboard(name: "Wallet", bundle: nil)
    public static let OrderStoryboard = UIStoryboard(name: "Order", bundle: nil)
    
    //public static let BASE_URL = ""  // Dev
    public static let BASE_URL = "https://redspark.a2hosted.com/events/api/web/event/users/"   // Live
    
    public static let Login = "login"
    public static let Sigup = "signup"
    public static let Spearkers = "speakers"
    public static let Events = "events"
    public static let Exhibitors = "exibitors"
    public static let attendevent = "attendevent"
    public static let meetingrequest = "meetingrequest"
    public static let meetingconfirmation = "meetingconfirmation"
    
    
    //--------
    public static let NetworkUnavailable = "Please Check network conection"
    public static let device_type = "2" // iOS = 2
    public static let FONT = "Lato"
    public static let FONTBold = "HelveticaNeue-Bold"
    
    
    
}


