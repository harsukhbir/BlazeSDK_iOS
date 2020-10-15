//
//  HubAdditionVCStep2.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubAdditionVCStep2: UIViewController,sendWifiName {
    
    

    @IBOutlet weak var ssidTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.title = "Hub addition step 2"
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func clickOnWifiListBtn(_ sender: Any) {
        let nextVC =  self.getViewController(with: .changeAccessPointVC, inStoryboard: .main) as! ChangeAccessPointVC
        nextVC.vcType = "add_hub"
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func clickOnConnectHub(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.isConnectHub(hubId: TestUtility().getAddingHubId()) { (status) in
            if(status == true){
                BlazeSdkClass.shared.sendWifiCredentials(ssid: self.ssidTF.text!, password: self.passwordTF.text!, hubId: TestUtility().getAddingHubId()) { (Response) in
                    debugPrint(Response)
                    if((Response["status"] as! Bool) == true){
                        SystemAlert().removeLoader()
                        self.pushToController(with: .hubAdditionVCStep3, inStoryboard: .main)
                    }else{
                         SystemAlert().removeLoader()
                         // connect again and check background hub is connected or not
                        //15 Oct 2020
                         self.pushToController(with: .hubAdditionVCStep3, inStoryboard: .main)
                    }
                }
            }else{
                SystemAlert().removeLoader()
                // connect again and check background hub is connected or not
                //15 Oct 2020
                self.pushToController(with: .hubAdditionVCStep3, inStoryboard: .main)

            }
        }
        
        
    }
    func getWifiName(wifiname: String) {
        ssidTF.text = wifiname
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
extension HubAdditionVCStep2 : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
