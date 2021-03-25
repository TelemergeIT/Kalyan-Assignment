//
//  AppStartRouter.swift
//  FAAST
//
//  Created by Kalyan Thakur on 24/04/20.
//  Copyright © 2020 FAAST. All rights reserved.
//

import UIKit

protocol AppStartRouter {
    func navigateToApp()
    func navigateToLogin()  
}


extension AppStartRouter where Self:Router {
    
    func navigateToApp() {

        if let tabbarVC = UIStoryboard(name: "Services", bundle: nil)
            .instantiateInitialViewController() {
            
            // After sign up app - we want to show user's profile first
            changeRootViewController(with: tabbarVC)
        }
        
    }
    
    func navigateToLogin()  {
        if let session = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? UINavigationController {
            
            // Start session worker
            
            // After sign up app - we want to show user's profile first
            changeRootViewController(with: session)
        }
    }
    private func changeRootViewController(with vc: UIViewController) {
        let transition: UIView.AnimationOptions = .transitionFlipFromLeft
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: transition, animations: { () -> Void in
            }) { (finished) -> Void in
                
            }
        }
    }
}
