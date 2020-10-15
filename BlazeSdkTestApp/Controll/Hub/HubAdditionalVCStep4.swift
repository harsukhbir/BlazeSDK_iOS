//
//  HubAdditionalVCStep4.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubAdditionalVCStep4: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var hubNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hub addition step 4"
        
    }
    
    @IBAction func clickOnAddHubBtn(_ sender: Any) {
        SystemAlert().showLoader()
        //15 OCt 20020
//        BlazeSdkClass.shared.addHub(hubId: TestUtility().getAddingHubId(), hubName: hubNameTF.text ?? "Test Hub") { (Response) in
//            debugPrint(Response)
//            if((Response["status"] as! Bool) == true){
//                self.getHubDetails()
//            }else{
//                SystemAlert().removeLoader()
//            }
//
//        }
        
        callApiForHubInstallation()
        
       
    }
    
    func getHubDetails() {
        BlazeSdkClass.shared.getHubDetails { (Response) in
            SystemAlert().removeLoader()
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                TestUtility().saveHubDetails(req : Response)
                self.pushToController(with: .homeVC, inStoryboard: .main)
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

    
    func callApiForHubInstallation(){
        
        let dict = ["installerId": "iOS"] as [String : Any]
        
        // https://api.dev.datadrivencare.net/hubs/C44F33354375/installation
        
        Webservices.instance.postMethod(connectionInfo.SERVER_URL + hubNameTF.text! + apiMethod.hubInstallation , param: dict) { (status, response) in
            if(status == true){
                
                SystemAlert().basicActionAlert(withTitle: "", message: "Hub Installed Successfully", actions: [.okAlert]) { (alert) in
                     self.pushToController(with: .homeVC, inStoryboard: .main)
                }
                
            }
//            else{
//                print("Get Response=>\(response)")
//                SystemAlert().basicActionAlert(withTitle: "", message: "", actions: [.okAlert]) { (alert) in
//                                   
//                               }
//            }
        }
    }
    
    
}
