//
//  ForgotPassWordVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 11/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class ForgotPassWordVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var codeStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnGetOtp(_ sender: Any) {
        BlazeSdkClass.shared.getOtpToForgotPassword(emailId: emailTF.text!) { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                self.codeStr = Response["code"] as! String
            }
        }
        
    }
    @IBAction func clickOnSavePassword(_ sender: Any) {
        
        BlazeSdkClass.shared.createNewPasswordWithOtp(otp: otpTF.text!, code: self.codeStr, password: self.passwordTF.text!) { (Response) in
            debugPrint(Response)
            if(Response["status"] as! Bool){
                SystemAlert().basicNonActionAlert(withTitle: "", message: "password changed successfully", alert: .okAlert)
            }
        }
   
        
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
