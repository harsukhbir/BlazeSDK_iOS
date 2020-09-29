//
//  ProfileVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class ProfileVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SystemAlert().showLoader()
        BlazeSdkClass.shared.getUserDetails { (Response) in
            debugPrint(Response)
            SystemAlert().removeLoader()
            if(Response["status"] as! Bool){
                self.firstNameTF.text = (Response["result"] as! NSDictionary)["first_name"] as? String
                self.lastNameTF.text = (Response["result"] as! NSDictionary)["last_name"] as? String
            }
        }
        
    }
    @IBAction func clickOnUpdateProfileBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.updateUserDetails(firstName: firstNameTF.text, lastName: lastNameTF.text) { (Response) in
            SystemAlert().removeLoader()
            if(Response["status"] as! Bool){
                SystemAlert().basicNonActionAlert(withTitle: "", message: "Profile update successfully.", alert: .okAlert)
            }
            debugPrint(Response)
        }
    }
    
    @IBAction func clickOnLogOutBtn(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: IntialVC.self) {
                TestUtility().clearAllDetails()
                self.navigationController?.popToViewController(controller, animated: true)
            }
            
        }
    }
    
    @IBAction func clickOnChangePasswordBtn(_ sender: Any) {
        self.pushToController(with: .changePassVC, inStoryboard: .main)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
