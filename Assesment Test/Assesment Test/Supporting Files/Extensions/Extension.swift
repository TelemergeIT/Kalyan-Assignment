//
//  Extension.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//


import UIKit
//import SDWebImage

extension UIView {
    
    
    internal func addLines () {
        
        let viewTop = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height:2))
        viewTop.backgroundColor = .gray
        viewTop.autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]

        let viewRight = UIView(frame: CGRect(x:self.frame.size.width - 2, y: 0, width:2, height:self.frame.size.height))
        viewRight.backgroundColor = .gray
        viewRight.autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]

        let viewBottom = UIView(frame: CGRect(x:0, y:self.frame.size.height - 2, width:self.frame.size.width, height:2))
        viewBottom.backgroundColor = .gray
        viewBottom.autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]

        let viewLeft = UIView(frame: CGRect(x:0, y:0, width:2, height:self.frame.size.height))
        viewLeft.backgroundColor = .gray
        viewLeft.autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]

        self.addSubview(viewTop)
        self.addSubview(viewRight)
        self.addSubview(viewBottom)
        self.addSubview(viewLeft)

    }
    
    internal func makeShadow (radius: Int) {
        
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    internal func makeRound () {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    internal func goRound () {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
    }
    final func addStatusBar(color:UIColor) {
        
        let height = UIApplication.shared.statusBarFrame.size.height
        let statusBarView = UIView.init(frame:CGRect(x: 0, y: 0, width:self.frame.size.width, height: height))
        statusBarView.backgroundColor = color
        self.addSubview(statusBarView)
    }
    final func addShadowBottom() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    final func addShadowToAllSides () {
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 200, green: 200, blue: 200, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    // OUTPUT 1
    final func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // OUTPUT 2
    final func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius

      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addDashedBorder(color: UIColor) {
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}

extension UILabel {
    final func boldFont(){
        self.font = UIFont.boldSystemFont(ofSize: 11.0)
    }
    
    final func regularFont() {
        self.font = UIFont.systemFont(ofSize: 10.0)
    }
}
extension UITextField {
    
    final func makeUnderLine () {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

internal extension Date {
    
    func toString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let string = dateFormatter.string(from:self)
        return string
    }
}

extension Date {
    func getElapInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day,.hour,.minute], from: self, to: Date())
        
        if let year = interval.year, year < 0 {
            return year == -1 ? "\(year)" + "y" :
                "\(year)" + " " + "y"
        } else if let month = interval.month, month < 0 {
            return month == -1 ? "\(month)" + "m" :
                "\(month)"  + "m"
        } else if let day = interval.day, day < 0 {
            var dayResult =  day == -1 ? "\(day)" + "d" :
                "\(day)" + "d"
            if let hour = interval.hour, hour < 0 {
                let hourResult =  hour == -1 ? "\(hour)" + "h" :
                    "\(hour)" + "h"
                dayResult = dayResult + " " + hourResult
            }
            return dayResult
        } else if let hour = interval.hour, hour < 0 {
            return hour == -1 ? "\(hour)" + " " + "hour" :
                "\(hour)" + " " + "hours"
        }
        else if let minute = interval.minute, minute < 0 {
            return minute == -1 ? "\(minute)" + " " + "minute" :
                "\(minute)" + " " + "minutes"
        }
        else {
            return "a moment ago"
            
        }
    }
}
internal extension String {
    
    func toDate() -> Date {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        let date = dateformatter.date(from: self)
        return date!
    }
    
    func convertToAttributed() -> NSAttributedString? {
        
        var attributedString:NSAttributedString?
        
        do {
            
            attributedString = try NSAttributedString(data:self.data(using: .utf8, allowLossyConversion: false)!, options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary([convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.documentType): convertFromNSAttributedStringDocumentType(NSAttributedString.DocumentType.html),convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.characterEncoding):String.Encoding.utf8.rawValue]), documentAttributes: nil)
            return attributedString
            
        } catch let error as NSError {
            
            print(error.userInfo)
        }
        return attributedString
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
    
    func removeNull()->String
    {
        if(self.count==0){
            return ""
        }
        else if(self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)=="<null>"||self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)=="(null)")
        {
            return ""
        }
        else
        {
            return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
    }
}
//extension UIImageView {
//    
//    func loadImage(imageUrl:String,defaultImage:String) {
//        
//        if imageUrl.count == 0 {
//            self.image = UIImage(named: defaultImage)
//        } else {
//            self.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: defaultImage))
//        }
//    }
//}
extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]), context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]), context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UITableView
{
    func snapshotRows(at indexPath: IndexPath) -> UIImage?
    {
        let rect = self.rectForRow(at:indexPath)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let cell = self.cellForRow(at: indexPath)
        cell?.layer.bounds.origin.y = self.rectForRow(at: indexPath).origin.y - (rect.minY + 10)
        cell?.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(UIViewController.donePressed))
        
        //        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIViewController.cancelPressed))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(){
        view.endEditing(true)
        self.resignFirstResponder()
    }
    func isModal() -> Bool {
        
        if let navigationController = self.navigationController{
            if navigationController.viewControllers.first != self{
                return false
            }
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor(hex: "3D3B3E")
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 6;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringDocumentReadingOptionKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.DocumentReadingOptionKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.DocumentReadingOptionKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentAttributeKey(_ input: NSAttributedString.DocumentAttributeKey) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentType(_ input: NSAttributedString.DocumentType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
extension Date {
    
    func daysBetween(start: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: self).day!
    }
    
    func getTimeIntoSeconds() -> Double {
        return self.timeIntervalSince1970
    }
    
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    //    func nanoseconds(from date: Date) -> Int {
    //        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    //    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 1 { return "\(years(from: date)) y"   }
        if years(from: date)   > 0 { return "\(years(from: date)) y"   }
        if months(from: date)  > 1 { return "\(months(from: date)) m ago"  }
        if months(from: date)  > 0 { return "\(months(from: date)) m ago"  }
        if weeks(from: date)   > 1 { return "\(weeks(from: date)) w ago"   }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) w ago"   }
        if days(from: date)    > 1 { return "\(days(from: date)) d ago"    }
        if days(from: date)    > 0 { return "\(days(from: date)) d ago"    }
        if hours(from: date)   > 1 { return "\(hours(from: date)) hr ago"   }
        if hours(from: date)   > 0 { return "\(hours(from: date)) hr ago"   }
        if minutes(from: date) > 1 { return "\(minutes(from: date)) min ago" }
        if minutes(from: date) > 0 { return "\(minutes(from: date)) min ago" }
        if seconds(from: date) > 1 { return "\(seconds(from: date)) sec ago" }
        if seconds(from: date) > 0 { return "\(seconds(from: date)) sec ago" }
        //if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date)) ns" }
        return ""
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIImage {

    func circularImage(size: CGSize?) -> UIImage {
        let newSize = size ?? self.size

        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()

        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)

        context!.setBlendMode(.copy)
        context!.setFillColor(UIColor.clear.cgColor)

        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return (result ?? nil)!
    }

}
