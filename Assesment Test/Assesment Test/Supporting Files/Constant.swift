//
//  Constant.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//

import UIKit

let appSharedData = AppsharedData.sharedInstance 
let networkManager = NetworkManager.sharedInstance
let coreDataManager = CoreDataManager.shared

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0

    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

let deviceType = "1" //1 for ios
let userType = "2" //User type is 2 for user app
let projectName = "Assesment Test"
let Version_name = UIDevice.current.systemVersion
let Company_name = "Apple"
let Model_name =  UIDevice.current.model
let iemi = "454564"
let deviceOSVersion = NSString(string: UIDevice.current.systemVersion)
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let versionBuildString = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
let userDefault = UserDefaults.standard
let COORDINATES = LocationManager.sharedManager.locationManager
let appdelegate = UIApplication.shared.delegate as! AppDelegate


//Global Dict
let additionalInfo = ["os_version":deviceOSVersion,"modelName":Model_name,"model_type":Model_name,"versionCode":versionBuildString!,"iemi":"iemi"] as [String : Any]


