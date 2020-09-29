//
//  RegisterViewController.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 07/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class RegisterVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnRegisterBtn(_ sender: Any) {
         SystemAlert().showLoader()
        BlazeSdkClass.shared.registerUser(firstName: userName.text!, lastName: userLastName.text!, emailId: emailID.text!, password: password.text!) { (Response) in
            
            debugPrint(Response)
            
            SystemAlert().removeLoader()
            if((Response["status"] as! Bool) == true){

                self.verifyUser(emailId: self.emailID.text!, code: Response["code"] as! String)
            }else{
                
            }
        }
        
    }
    
    func verifyUser(emailId : String, code : String) {
        
        self.showAlertWithTextField(title: "Register", message: "Check mail and enter otp", placeholder: "otp") { (otp) in
            
            if(otp.count < 5){
                // eneter valid otp
                return
            }
            SystemAlert().showLoader()
            
            BlazeSdkClass.shared.verifyRegisteredUser(emailId: emailId, code: code, otp: otp) { (Response) in
                debugPrint(Response)
                if((Response["status"] as! Bool) == true){
                    TestUtility().saveLoginDetails(req: Response)
                    BlazeClient.shared.userId = Response["user_id"] as! String
                    BlazeClient.shared.emailId = emailId
                    self.genarateTokens()
                }else{
                     SystemAlert().removeLoader()
                }
                
                
            }
        }
        
        
        
    }
    
    
    func genarateTokens() {
        
        let userDetails = TestUtility().extractLoginDetails()
        BlazeSdkClass.shared.getAccessToken(userId: userDetails["user_id"] as! String, code: userDetails["code"]  as! String) { (Response) in
            debugPrint(Response)
             SystemAlert().removeLoader()
            if((Response["status"] as! Bool) == true){
                TestUtility().saveTokenDetails(req: Response)
                BlazeClient.shared.accesToken = (Response["access_token"] as! String)
                self.pushToController(with: .hubScannedListVC, inStoryboard: .main)
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
