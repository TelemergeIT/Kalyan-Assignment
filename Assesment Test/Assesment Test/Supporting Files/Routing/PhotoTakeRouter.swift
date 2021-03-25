//
//  PhotoTakeRouter.swift
//  FAAST
//
//  Created by Kalyan Thakur on 24/04/20.
//  Copyright © 2020 FAAST. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

protocol PhotoTakeRouter {
    func navigateToSelectingImageSource(allowEditing: Bool)
    func navigateToCamera(allowEditing: Bool)
    func navigateToGallery(allowEditing: Bool)
    func navigateToDocument()
}

extension PhotoTakeRouter where Self: Router {
    
    func navigateToSelectingImageSource(allowEditing: Bool = true){
        
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: nil,
                                                         preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { action in
            self.navigateToCamera(allowEditing: allowEditing)
        }
        
        let galleryAction = UIAlertAction(title: "Choose From Library", style: .default) { action in
            self.navigateToGallery(allowEditing: allowEditing)
        }
        let documentAction = UIAlertAction(title: "Choose Document", style: .default) { action in
            self.navigateToDocument()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(documentAction)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func navigateToCamera(allowEditing: Bool) {
        guard let viewController = self.viewController as? UIViewController else {
            return
        }
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted : Bool) in
            if granted == true{
                    if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                        DispatchQueue.main.async {
                            let imagePicker = UIImagePickerController()
                            imagePicker.sourceType = .camera
                            imagePicker.allowsEditing = allowEditing
                            imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
                            viewController.present(imagePicker, animated: true, completion: nil)
                        }
                        
                }else{
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alert.addAction(action)
                            viewController.present(alert, animated: true, completion: nil)
                        }
                    
                }
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: projectName, message: "This app is not authorized to use Camera.", preferredStyle: .alert)
                    let setting = UIAlertAction(title: "Setting", style: .default, handler: { (action) in
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    })
                    let cancle = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    alert.addAction(setting)
                    alert.addAction(cancle)
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    func navigateToGallery(allowEditing: Bool) {
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = allowEditing
            imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func navigateToDocument() {
        
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
            //Call Delegate
            documentPicker.delegate = viewController as? (UIDocumentPickerDelegate)
            viewController.present(documentPicker, animated: true, completion: nil)
        }
    }
}
