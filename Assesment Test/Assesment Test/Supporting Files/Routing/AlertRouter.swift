//
//  AlertRouter.swift
//  FAAST
//
//  Created by Kalyan Thakur on 24/04/20.
//  Copyright © 2020 FAAST. All rights reserved.
//

import UIKit
import CoreLocation

enum AlertType {
    case Unfollow
    case SendMessage
    case Report
    case Block
}

enum AlertTypeBlog {
    case ReportSpam
    case ReportUnappropriate
}

enum ShareTypePost {
    case ShareTypeSendMessage
    case ShareTypeShareOnSocialMedia
}

protocol AlertRouter {
    func showAlert(message: String)
    func dismiss(completion: (() -> ())?)
    func dismissWithoutAnimation(completion: (() -> ())?)
    func showSending(withText text: String)
}

extension AlertRouter where Self: Router {

    typealias AlertTypeProfileCompletion = (AlertType)->Void
    typealias AlertTypeReportCompletion = (AlertTypeBlog)->Void
    typealias ShareTypePostCompletion = (ShareTypePost)->Void

    func showAlert(message: String){
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
    
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: message,
                                                         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showSending(withText text: String = "Sending...") {
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: text,
                                                         preferredStyle: .alert)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showOkActionAlert(message: String,completion:@escaping (Bool) -> Void){
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
    
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: message,
                                                         preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            completion(true)
        }
        alert.addAction(yesAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    

    func showAlertwithOptions (optionTitle:String,cancelTitle:String,closeTitle:String?,message:String,completion:@escaping (Bool) -> Void) {
        
        guard let viewController = viewController as? UIViewController else {
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
        if let closeTitle = closeTitle {
            let closeAction = UIAlertAction(title: closeTitle, style: .default) { (alert) in
            }
            alert.addAction(closeAction)
        }
        viewController.present(alert, animated: true, completion: nil)

    }
    
    func showAlertwithOptionsAndTitle (title: String,optionTitle:String,cancelTitle:String,message:String,completion:@escaping (Bool) -> Void) {
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        let alert: UIAlertController = UIAlertController(title: title,
                                                         message: message,
                                                         preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: optionTitle, style: .default) { (alert) in
            completion(true)
        }
        
        let noAction = UIAlertAction(title: cancelTitle, style: .cancel) { (alert) in
            completion(false)
        }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func showActionSheet(title: String,optionTitle:String,cancelTitle:String,message:String,completion:@escaping (Bool?) -> Void){
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        // 1
         let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
             
         // 2
        let deleteAction = UIAlertAction(title: optionTitle, style: .default){ (alert) in
                    completion(true)
           }
        let saveAction = UIAlertAction(title: cancelTitle, style: .default){ (alert) in
                    completion(false)
           }
             
         // 3
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (alert) in
                  completion(nil)
         }
             
         // 4
         optionMenu.addAction(deleteAction)
         optionMenu.addAction(saveAction)
         optionMenu.addAction(cancelAction)
             
         // 5
         viewController.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func dismiss(completion: (() -> ())? = nil){
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        viewController.dismiss(animated: true, completion: completion)
    }
    
    func dismissWithoutAnimation(completion: (() -> ())? = nil){
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        viewController.dismiss(animated: false, completion: completion)
    }
 
}
