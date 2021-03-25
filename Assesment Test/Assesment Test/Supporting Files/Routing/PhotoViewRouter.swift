//
//  PhotoViewRouter.swift
//  FAAST
//
//  Created by Kalyan Thakur on 24/04/20.
//  Copyright © 2020 FAAST. All rights reserved.
//

import UIKit
//import GSImageViewerController

protocol PhotoViewRouter {
    func navigateToPhotoViewer(imageView: UIImageView)
}

extension PhotoViewRouter where Self: Router {
    
//    func navigateToPhotoViewer(imageView: UIImageView){
//        
//        guard let viewController = viewController as? UIViewController,
//            let image = imageView.image else {
//            return
//        }
//        
//        let imageInfo = GSImageInfo(image: image, imageMode: .aspectFit, imageHD: nil)
//        let transitionInfo = GSTransitionInfo(fromView: imageView)
//        transitionInfo.duration = 0.3
//        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
//        
//        viewController.present(imageViewer, animated: true, completion: nil)
//        
//    }
}
