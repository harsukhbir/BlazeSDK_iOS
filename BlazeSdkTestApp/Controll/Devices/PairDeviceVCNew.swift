//
//  PairDeviceVCNew.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 15/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk


class PairDeviceVCNew: UIViewController,UITextFieldDelegate {
        @IBOutlet weak var noidIdLbl: UILabel!
        @IBOutlet weak var boneIdLbl: UILabel!
        
        @IBOutlet weak var deviceNameTF: UITextField!
        
        @IBOutlet weak var pairDevicebtn: UIButton!
        @IBOutlet weak var addDeviceBtn: UIButton!
        var catType: String!
        var deviceTypeName: String!
        var deviceModelName: String!
        var deviceLocationName: String!
        @IBOutlet weak var imgVw: UIImageView!
    
    let imagePicker = UIImagePickerController()
       var photoString = ""
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = deviceTypeName
            //15 Oct 2020
    //        addDeviceBtn.isEnabled = false
    //        addDeviceBtn.alpha = 0.5

            // Do any additional setup after loading the view.
            
             imagePicker.delegate = self
        }
        @IBAction func clickOnPairDeviceBtn(_ sender: Any) {
            SystemAlert().showLoader()
            BlazeSdkClass.shared.pairDevice(hubId: TestUtility().getSelectedHubId(), catType: catType, deviceType: "ZIGBEE") { (Response) in
               SystemAlert().removeLoader()
                if(Response["status"] as! Bool){
                     
                    self.noidIdLbl.text = (Response["node_id"] as! String)
                    self.boneIdLbl.text = (Response["device_b_one_id"] as! String)
                    self.addDeviceBtn.isEnabled = true
                    self.addDeviceBtn.alpha = 1
                    self.pairDevicebtn.isEnabled = false
                    self.pairDevicebtn.alpha = 0.5
                }else{
                }
            }
        
        }
       
        @IBAction func clickOnAddDeviceButton(_ sender: Any) {
            SystemAlert().showLoader()
            BlazeSdkClass.shared.addDevice(hubId: TestUtility().getSelectedHubId(), catType: catType, deviceType: "ZIGBEE", deviceName: deviceNameTF.text!, nodeId: self.noidIdLbl.text!, b_OneId: self.boneIdLbl.text!) { (Response) in
                SystemAlert().removeLoader()
                if(Response["status"] as! Bool){
                    
                    SystemAlert().basicNonActionAlert(withTitle: "", message: "Device Added Successfully", alert: .doneAlert)
                    
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: HomeVC.self) {
                            self.navigationController?.popToViewController(controller, animated: true)
                        }
                        
                    }
                }//15Ocxt 2020
                else{
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: HomeVC.self) {
                            self.navigationController?.popToViewController(controller, animated: true)
                        }
                        
                    }
                }
            }
       
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return true
        }

        
        @IBAction func acn_TakePhoto(_ sender: Any) {
            self.showActionSheet(vc: self)
        }
    
     
        func camera()
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                
                present(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        func photoLibrary()
        {
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                
                present(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        func showActionSheet(vc: UIViewController) {
          
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.camera()
            }))
            
    //        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
    //            self.photoLibrary()
    //        }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            vc.present(actionSheet, animated: true, completion: nil)
    }
        
        @IBAction func acn_FinishBtn(_ sender: Any) {
            callApiForHubAddSensor()
        }
    
    func callApiForHubAddSensor(){
        
      let dict = ["installationPhoto": photoString,
                    "location": deviceLocationName ?? "",
                    "model": deviceModelName ?? "",
                    "pairingId": "string",
                    "type": deviceTypeName ?? ""] as [String : Any]
    
        Webservices.instance.postMethod(connectionInfo.SERVER_URL + apiMethod.hubAddSensor , param: dict) { (status, response) in
            if(status == true){
                
                SystemAlert().basicActionAlert(withTitle: "", message: "Sensor Added Successfully", actions: [.okAlert]) { (alert) in
//                    self.pushToController(with: .hubScannedListVC, inStoryboard: .main)
                    self.pushToController(with: .homeVC, inStoryboard: .main)
                }
            }
        }
    }
}

extension PairDeviceVCNew: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                dismiss(animated: true, completion: nil)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    imgVw.contentMode = .scaleAspectFit
                    imgVw.image = pickedImage
                    photoString = convertImageToBase64String(img: pickedImage)
                }
                
                dismiss(animated: true, completion: nil)
            }
            
            func convertImageToBase64String (img: UIImage) -> String {
                let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
                let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
                return imgString
            }
}
