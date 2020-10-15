//
//  Utility+Extension.swift
//  WattsUp
//
//  Created by Gopi Krishna on 11/03/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import Foundation
import UIKit

var defaults = UserDefaults.standard
let nCenter = NotificationCenter.default

enum StoryboardIdentifiers: String {
    case intialVC = "IntialVC"
    case loginVC = "LoginVC"
    case registerVC = "RegisterVC"
    case hubAdditionVCStep1 = "HubAdditionVCStep1"
    case hubAdditionVCStep2 = "HubAdditionVCStep2"
    case hubAdditionVCStep3 = "HubAdditionalVCStep3"
    case hubAdditionVCStep4 = "HubAdditionalVCStep4"
    case hubListVC = "HubListVC"
    case homeVC = "HomeVC"
    case deviceListVC = "DeviceListVC"
    case profileVC = "ProfileVC"
    case forgotPassVC = "ForgotPassWordVC"
    case changePassVC = "ChangePasswordVC"
    case settingsVC = "SettingsVC"
    case hubScannedListVC = "HubScannedListVC"
    case pairDeviceVC = "PairDeviceVC"
    case deviceInternalVC = "DeviceInternalVC"
    case changeAccessPointVC = "ChangeAccessPointVC"
    case connectToWifi = "ConnectToWifi"
    case installSensor = "InstallSensorVC"
    case powerUpHub = "PowerUpHubVC"
     case pairDeviceVCNew = "PairDeviceVCNew"

}

enum StoryboardNames: String {
    case main = "Main"
    case intialVC = "IntialVC"
    case loginVC = "LoginVC"
    case registerVC = "RegisterVC"
    case hubAdditionVCStep1 = "HubAdditionVCStep1"
    case hubAdditionVCStep2 = "HubAdditionVCStep2"
    case hubAdditionVCStep3 = "HubAdditionalVCStep3"
    case hubAdditionVCStep4 = "HubAdditionalVCStep4"
    case hubListVC = "HubListVC"
    case homeVC = "HomeVC"
    case deviceListVC = "DeviceListVC"
    case profileVC = "ProfileVC"
    case forgotPassVC = "ForgotPassWordVC"
    case changePassVC = "ChangePasswordVC"
    case settingsVC = "SettingsVC"
    case hubScannedListVC = "HubScannedListVC"
    case pairDeviceVC = "PairDeviceVC"
    case deviceInternalVC = "DeviceInternalVC"
    case changeAccessPointVC = "ChangeAccessPointVC"
}

extension UIViewController {
    /// Given the storyboardID a (String),inStoryboard a name (String)
    /// returns nil, and Navigate to desired controller form mentioned storyboard
    func pushToController(with storyboardID:StoryboardIdentifiers, inStoryboard name:StoryboardNames){
        DispatchQueue.main.async {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: name.rawValue, bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier:storyboardID.rawValue)
            self.navigationController?.pushViewController(newViewcontroller, animated: true)
        }
    }
    
    func getViewController(with storyboardID:StoryboardIdentifiers, inStoryboard name:StoryboardNames)-> UIViewController{
        let mainstoryboard:UIStoryboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier:storyboardID.rawValue)
        return newViewcontroller
    }
    
    func moveBackToController<T: UIViewController>(_ objectType: T.Type){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: T.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    /// Given the fromStoryboard as name (StoryboardNames),with storyboardID (StoryboardIdentifiers)
    /// returns viewController of that storyboard Id
    func getController(fromStoryboard name:StoryboardNames,with storyboardID:StoryboardIdentifiers) -> UIViewController{
        let mainstoryboard:UIStoryboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier:storyboardID.rawValue)
        return newViewcontroller
    }
    
    
    
    func pushBackToPreviousController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapBackToPreviousController(_ sender: Any) {
        self.pushBackToPreviousController()
    }
    
    func showAlertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil,text: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
            newTextField.text = text ?? ""
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result)
                
            }
            else
            { completion("")
                
            }
        })
        navigationController?.present(alert, animated: true)
    }

   func attributedString(str:String)->NSAttributedString{
       // create attributed string
    
    let defaultBlueColor = UIColor(red: 45/255, green: 188/255, blue: 240/255, alpha: 1)
       let myString = str
    let myAttribute = [ NSAttributedString.Key.foregroundColor: defaultBlueColor ]
       let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)

       // set attributed text on a UILabel
     return myAttrString
   }
    
}



