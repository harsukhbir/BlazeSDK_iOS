//
//  LoginViewController.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 07/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk
class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func clickOnLoginBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.loginUser(emailId: userName.text!, password: password.text!) { (ResponseObj) in
            debugPrint(ResponseObj)
            if((ResponseObj["status"] as! Bool) == true){
                TestUtility().saveLoginDetails(req: ResponseObj)
                BlazeClient.shared.userId = ResponseObj["user_id"] as! String
                BlazeClient.shared.emailId = self.userName.text!
                self.genarateTokens()
            }else{
                 SystemAlert().removeLoader()
                SystemAlert().basicNonActionAlert(withTitle: "", message: ResponseObj["message"] as! String, alert: .okAlert)
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
                self.getHubDetails()
            }
        }
        
    }
    
    func getHubDetails() {
        BlazeSdkClass.shared.getHubDetails { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                if (Response["data"] as! NSArray).count > 0 {
                    TestUtility().saveHubDetails(req : Response)
                    TestUtility().setSelectedHubId(hubId: ((Response["data"] as! NSArray)[0] as! NSDictionary)["hub_id"] as! String)
                    self.pushToController(with: .homeVC, inStoryboard: .main)
                }else{
                    self.pushToController(with: .hubScannedListVC, inStoryboard: .main)
                }
                
            }else{
                 self.pushToController(with: .hubScannedListVC, inStoryboard: .main)
            }
        }
    }

    @IBAction func clickOnForgotPassword(_ sender: Any) {
        
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
