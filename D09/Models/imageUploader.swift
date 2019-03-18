//
//  ImageUploader.swift
//  D09
//
//  Created by Alina FESYK on 3/3/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import Foundation
import Photos
import AVFoundation

class ImageUploader: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    unowned let viewController: ArticleVC
    let imagePicker: UIImagePickerController
    
    init(to viewController: ArticleVC) {
        imagePicker = UIImagePickerController()
        self.viewController = viewController
        super.init()
        
        imagePicker.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func selectImageFrom(_ source: UIImagePickerController.SourceType) {
        imagePicker.sourceType = source
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func accessGallery() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            pickImage()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({newStatus in
                print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized {
                    self.pickImage()
                }
            })
        case .restricted:
            viewController.alert(title: "Failed to access gallery", message: "Permission is restricted", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
        case .denied:
            viewController.alert(title: "Failed to access gallery", message: "Permission is denied", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            print("User has denied the permission.")
        }
    }
    
    func accessCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            viewController.alert(title: "Ooops!", message: "Camera is not available on this device", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        let cameraAccessStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAccessStatus {
        case .authorized:
            selectImageFrom(.camera)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.selectImageFrom(.camera)
                }
            }
        case .restricted:
            viewController.alert(title: "Failed to access camera", message: "Permission is restricted", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
        case .denied:
            viewController.alert(title: "Failed to access camera", message: "Permission is denied", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            print("User has denied the permission.")
        }
    }
    
    fileprivate func pickImage() {
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            viewController.articleImage.image = pickedImage
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
