//
//  ChangePasswordVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 12/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class ChangePasswordVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickOnUpdatePasswordBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.changePasword(password: currentPasswordTF.text!, newPassword: newPasswordTF.text!) { (Response) in
             SystemAlert().removeLoader()
            debugPrint(Response)
            if(Response["status"] as! Bool){
                SystemAlert().basicNonActionAlert(withTitle: "", message: Response["message"] as! String, alert: .okAlert)
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
