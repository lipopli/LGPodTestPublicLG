//
//  ImagePickerHelper.swift
//  CareInsureAssess
//
//  Created by 李功骄 on 2021/4/19.
//

import UIKit
import Photos

class ImagePickerHelper: NSObject {
    
    private  var didFinishPickingCallBack: ((UIImage)->())?
    
    static func takePhoto(complte : @escaping (UIImage)->()) {
        let picker = ImagePickerHelper.shared
        picker.didFinishPickingCallBack = complte
        picker.takePhoto()
    }
    
    static let shared = ImagePickerHelper()
    
    private var imagePickerVc = UIImagePickerController()
    
    private override init() {
        super.init()
        
        imagePickerVc.delegate = self
        let tzBarItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [TZImagePickerController.self])
        let barItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIImagePickerController.self])
        
        let titleTextAttributes = tzBarItem.titleTextAttributes(for: .normal)
        barItem.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
   private func takePhoto() {
        
     
        
        let  authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            let alert = UIAlertController(title: "无法使用相机", message: "请在iPhone的“设置-隐私-相机”中允许访问相机", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_action) in
            }))
            
            alert.addAction(UIAlertAction(title: "设置", style: .default, handler: { (_action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:]) { (complte) in
                        
                    }
                }
            }))
            UIViewController.topController().present(alert, animated: true, completion: nil)
            
        }else if authStatus == .notDetermined {
            //防止用户首次拍照拒绝授权时相机页黑屏
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.takePhoto()
                    }
                }
            }
            // 拍照之前还需要检查相册权限
        }else if PHPhotoLibrary.authorizationStatus().rawValue == 2 {
            //已被拒绝，没有相册权限，将无法保存拍的照片
            let alert = UIAlertController(title: "无法使用相机", message: "请在iPhone的“设置-隐私-相册”中允许访问相册", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_action) in
            }))
            
            alert.addAction(UIAlertAction(title: "设置", style: .default, handler: { (_action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:]) { (complte) in
                        
                    }
                }
            }))
            
            UIViewController.topController().present(alert, animated: true, completion: nil)
        }else if PHPhotoLibrary.authorizationStatus().rawValue == 0 {
            // 未请求过相册权限
            TZImageManager.default()?.requestAuthorization(completion: {
                self.takePhoto()
            })
        }else {
            pushImagePickerController()
        }
        
    }
    
    func pushImagePickerController() {
        let sourceType =  UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePickerVc.sourceType = sourceType
            UIViewController.topController().present(imagePickerVc, animated: true, completion: nil)
        }
    }

    
}

extension ImagePickerHelper : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let type = info[UIImagePickerController.InfoKey.mediaType]
        if let type = type as? String , type == "public.image" {
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.didFinishPickingCallBack?(img)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
