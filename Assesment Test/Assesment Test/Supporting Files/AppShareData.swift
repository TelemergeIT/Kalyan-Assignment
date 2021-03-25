//
//  AppShareData.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//

import UIKit
import IQKeyboardManagerSwift

class AppsharedData: NSObject {
    var urlAddress:String?
    
    static let sharedInstance = AppsharedData()
    var countriesArray:NSMutableArray = NSMutableArray.init()
    
    var advertisingIdentifier:NSString
    var didCardGenerated:Bool = false
    var didFromHomeLogin = false
    var didFromHomeSignup = false
    var didResignWelcomeScreen = false 
    
    override init() {
        advertisingIdentifier = ""
    }

    
    let additionalInfo = [
        "os_version":deviceOSVersion,
        "model_type":Model_name,
        "iemi":iemi,
        "version_name":versionBuildString ?? 1.0,
        "version_code":versionBuildString ?? 1.0,
        "model_name":Model_name,
        "mobile_brand":"Apple",
        "app_version":versionBuildString ?? 1.0
        ] as [String : Any]
    
    //MARK: - Alert View Controller
    func showAlertControllerWith(title : String, andMessage:String)  {
        let viewcontroller = self.getVisibleViewController(nil)
        let otherAlert = UIAlertController(title: title, message: andMessage, preferredStyle: UIAlertController.Style.alert)
        
        
        let dismiss = UIAlertAction(title: "OK", style:UIAlertAction.Style.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(dismiss)
        
        viewcontroller?.present(otherAlert, animated: true, completion: nil)
    }
    
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        let rootVC = rootViewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if rootVC!.isKind(of: UINavigationController.self) {
            let navigationController = rootVC as! UINavigationController
            return getVisibleViewController(navigationController.viewControllers.last!)
        }
        
        if rootVC!.isKind(of: UITabBarController.self) {
            let tabBarController = rootVC as! UITabBarController
            return getVisibleViewController(tabBarController.selectedViewController!)
        }
        
        if let presentedVC = rootVC?.presentedViewController {
            return getVisibleViewController(presentedVC)
        }
        
        return rootVC
    }
    func showAlertwithOptions (optionTitle:String,cancelTitle:String,message:String,completion:@escaping (Bool) -> Void) {
        
        guard  let viewcontroller = self.getVisibleViewController(nil) else {
            return
        }
        
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: message,
                                                         preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: optionTitle, style: .default) { (alert) in
            completion(true)
        }
        
        let noAction = UIAlertAction(title: cancelTitle, style: .default) { (alert) in
            completion(false)
        }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        viewcontroller.present(alert, animated: true, completion: nil)
        
    }
    func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = rootViewController
        }
    }
    
    //MARK: for validation
    func isEmailValid(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    let emailAcceptableCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@"
    let passwordAcceptableCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@!#$%^&*()_+=-<>?:|,./;'+-"
    let AddressAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,/- "
    let ZipCodeAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890- "
    let numberAcceptableCharacter = "1234567890"
    let decimalAcceptableCharacter = "1234567890."
    let PhoneNoAcceptableCharacter = "1234567890+"
    let nameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. "
    
    //Shake Animation for the view
    func shakeAnimation(viewToShake:UIView){
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( caTransform3D:CATransform3DMakeTranslation(-5, 0, 0 ) ),
            NSValue( caTransform3D:CATransform3DMakeTranslation( 5, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 5/100
        
        viewToShake.layer.add( anim, forKey:nil )
        
    }
    
    func shakreAnimation(textField:UITextField) {
        AppsharedData().shakeAnimation(viewToShake: textField)
    }
    
    func checkEnterFloatInTextFiled(strValue : String) -> Bool{
        if let BudgetValue : Float  = Float(strValue){
            if BudgetValue <= Float(100000000.00){
                let arrFloatBrack : [String] = strValue.components(separatedBy: ".")
                if arrFloatBrack.count >= 2{
                    let afterDot = arrFloatBrack[1]
                    if afterDot.count <= 2{
                        return true
                    }
                    return false
                }
                return true
            }
        }
        return false
    }
    //MARK:- Encoding image from base64
    func encodedBase64String(image:UIImage?) -> String? {
        
        let resizeImage = getResizedImage(image: image)
        
        if resizeImage != nil {
            
            if let data = resizeImage!.pngData() {
                let rImage = data.base64EncodedString(options: [])
                return String(format:"data:image/jpeg;base64,%@",rImage)
            }
        }
        
        return ""
    }
    //MARK:- Geting new Image as Image resize
    func getResizedImage(image:UIImage?) -> UIImage? {
        
        if image != nil {
            
            let lower : Int = 300
            let upper : Int = (Int(UIScreen.main.bounds.size.height)/2)+100
            let randomIntFrom0To10 = Int.random(in: lower ..< upper)
            print(randomIntFrom0To10)
            
            let newSize = CGSize(width: Int(randomIntFrom0To10), height: Int(randomIntFrom0To10))
            UIGraphicsBeginImageContext(newSize)
            if (image?.size.height ?? 0) < newSize.height {
                image?.draw(in: CGRect(x: 0, y: 0, width: (image?.size.width ?? 0), height: (image?.size.height ?? 0)))
            } else {
                image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
        return image
    }
    func progressImage(with progress : Float) -> UIImage {
        let layer = CALayer()
        layer.backgroundColor = UIColor.appOrange.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        layer.cornerRadius = 15

        let label = UILabel(frame: layer.frame)
        label.text = String(format: "%.0f", progress)
        label.font = UIFont(name: "Manrope-Bold", size: 17)
        label.textColor = .white
        label.transform = CGAffineTransform.init(rotationAngle: CGFloat(Float.pi/2))
        layer.addSublayer(label.layer)
        label.textAlignment = .center
        label.tag = 100

        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //MARK:- For validating the URL
    func validateUrl (urlString: NSString) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }

    func getDateFormater (_ format:String)-> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT+0:00")
        return dateFormatter
    }
    
    func getDateFormaterWithoutGMT (_ format:String)-> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    func convertDateFormatFromForDate(fromFormat: String, toFormat: String, stringDate: String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
    func getCurrentDateWith(stringDate: String)-> Date? {
        let currentDate = self.getDateFormaterWithoutGMT("dd-MM-yyyy").string(from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        guard let date = dateFormatter.date(from: String(format: "%@ %@", currentDate,stringDate))  else {
            return Date()
        }
        print(self.getDateFormaterWithoutGMT("dd-MM-yyyy HH:mm:ss").string(from: date))
        return date
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: testStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, testStr.count)) != nil
        } catch {
            return false
        }
    }
    
    internal func addUnderLineToText (text:String) -> NSMutableAttributedString {
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttributes([NSAttributedString.Key.underlineColor:UIColor.black,NSAttributedString.Key.foregroundColor:UIColor.black], range: textRange)
        // Add other attributes if needed
        return attributedText
    }
    
    func addDifferentColorToText (fulltext:String, coloredtext:String, normalColor:UIColor, highlightedColor:UIColor) -> NSMutableAttributedString {
        let textRange = fulltext.nsRange(from: fulltext.range(of: coloredtext)!)
        let attributedText = NSMutableAttributedString(string: fulltext)
        attributedText.addAttributes([NSAttributedString.Key.underlineColor:UIColor.black,NSAttributedString.Key.foregroundColor:normalColor], range: NSMakeRange(0, fulltext.count))
        attributedText.addAttributes([NSAttributedString.Key.underlineColor:UIColor.black,NSAttributedString.Key.foregroundColor:highlightedColor], range: textRange)
        // Add other attributes if needed
        return attributedText
    }
    
    func fetchDayName(_ dayName:Int) -> String {
        
        switch dayName {
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        case 1:
            return "SUN"
        default:
            return ""
        }
    }

    
    func fetchDayNameFull(_ dayName:Int) -> String {
        
        switch dayName {
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        case 1:
            return "Sunday"
        default:
            return ""
        }
    }
    
    func isPasswordValid(_ testStr:String) -> Bool {
        // let stricterFilter = false
        let emailReg = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,10}"
        //let emailRegEx = stricterFilter ? stricterFilterString : laxString;
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func enableIQ (_ enable:Bool) {
        IQKeyboardManager.shared.enable = enable
    }
    
    static func showAlertControllerWith(title : String, andMessage:String)  {
        let viewcontroller = self.getVisibleViewController(nil)
        let otherAlert = UIAlertController(title: title, message: andMessage, preferredStyle: UIAlertController.Style.alert)
        
        
        let dismiss = UIAlertAction(title: "OK", style:UIAlertAction.Style.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(dismiss)
        
        viewcontroller?.present(otherAlert, animated: true, completion: nil)
    }
    static func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
    
    func addBadgeValueonRightBarItems(button : UIButton, cartCount: Int)  {
        button.viewWithTag(100)?.removeFromSuperview()
        if cartCount != 0 {
            let label = UILabel.init(frame: CGRect.init(x: button.frame.size.width/2, y: 3, width: 16, height: 16))
            label.backgroundColor = UIColor.appOrange
            label.textColor = UIColor.white
            label.text = String(format: "%d", cartCount)
            label.font = UIFont.systemFont(ofSize: 9)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.tag = 100
            label.clipsToBounds = true
            button.addSubview(label)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }

    // Helper function inserted by Swift 4.2 migrator.
    func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }

}
