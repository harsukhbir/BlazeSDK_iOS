//
//  ConnectToWifi.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 29/09/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class ConnectToWifi: UIViewController{//,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
fileprivate var currentVC: UIViewController!
    @IBOutlet weak var imgVw: UIImageView!
    let imagePicker = UIImagePickerController()
    var photoString = ""
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgAction))

        imgVw.addGestureRecognizer(tap)
        
        imagePicker.delegate = self
    }
    @objc func imgAction(){

       self.showActionSheet(vc: self)
        

    }

    @IBAction func acn_backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        currentVC = vc
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
    
    func callApiForHubAddSensor(){
        
        let dict = ["installationPhoto": photoString,
                    "location":"bathroom",
                    "model": "doorv1",
                    "pairingId": "string",
                    "type": "door"] as [String : Any]
        
      
        
        Webservices.instance.postMethod(connectionInfo.SERVER_URL + apiMethod.hubAddSensor , param: dict) { (status, response) in
            if(status == true){
                
                SystemAlert().basicActionAlert(withTitle: "", message: "Sensor Add Successfully", actions: [.okAlert]) { (alert) in
                    let nextVC =  self.getViewController(with: .powerUpHub, inStoryboard: .main) as! PowerUpHubVC
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                }
                
            }
        }
    }

    @IBAction func acn_NextBtn(_ sender: Any) {
        
        callApiForHubAddSensor()
    }

}

extension ConnectToWifi: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

//extension String {
//
//    func convertImageToBase64String (img: UIImage) -> String {
//        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
//        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
//        return imgString
//    }
//
//}
